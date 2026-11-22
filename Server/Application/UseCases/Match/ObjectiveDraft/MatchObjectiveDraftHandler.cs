using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal sealed class MatchObjectiveDraftHandler
    {
        private readonly Ports.IMatchStateStore _matchStateStore;

        public MatchObjectiveDraftHandler(Ports.IMatchStateStore matchStateStore)
        {
            _matchStateStore = matchStateStore ?? throw new ArgumentNullException(nameof(matchStateStore));
        }
        private const int MaximumObjectiveDraftRequestsPerSecond = 4;
        private const int MaximumRetainedObjectiveDraftDecisionsPerParticipant = 128;

        public ObjectiveDraftDecision ProcessObjectiveDraftAction(
            ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            var objectiveDraftDecision = new ObjectiveDraftDecision
            {
                ObjectiveDraftSubmissionId = objectiveDraftSubmission?.ObjectiveDraftSubmissionId ?? Guid.Empty,
                RejectionReason = ObjectiveDraftRejectionReason.InvalidSubmission
            };
            if (objectiveDraftSubmission != null && !string.IsNullOrWhiteSpace(objectiveDraftSubmission.LobbyCode))
            {
                MatchState matchState = _matchStateStore.FindMatch(objectiveDraftSubmission.LobbyCode);
                if (matchState != null)
                {
                    lock (matchState)
                    {
                        objectiveDraftDecision = ProcessObjectiveDraftUnderLock(
                            matchState, objectiveDraftSubmission, participantUserId);
                    }
                }
                else
                {
                    objectiveDraftDecision = objectiveDraftDecision with
                    {
                        RejectionReason = ObjectiveDraftRejectionReason.MatchUnavailable
                    };
                }
            }
            return objectiveDraftDecision;
        }

        private static ObjectiveDraftDecision ProcessObjectiveDraftUnderLock(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            var objectiveDraftDecision = new ObjectiveDraftDecision
            {
                ObjectiveDraftSubmissionId = objectiveDraftSubmission.ObjectiveDraftSubmissionId,
                CommittedMatchStateVersion = matchState.MatchStateVersion,
                RejectionReason = ObjectiveDraftRejectionReason.ParticipantNotAllowed
            };
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            if (participantSeat >= 0)
            {
                objectiveDraftDecision = ResolveObjectiveDraftSubmission(
                    matchState, objectiveDraftSubmission, participantUserId);
            }
            return objectiveDraftDecision;
        }

        private static ObjectiveDraftDecision ResolveObjectiveDraftSubmission(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            ObjectiveDraftDecision objectiveDraftDecision;
            if (matchState.ProcessedObjectiveDrafts.TryGetValue(objectiveDraftSubmission.ObjectiveDraftSubmissionId,
                out ProcessedObjectiveDraft processedDraft))
            {
                bool isSameRequest = processedDraft.ParticipantUserId == participantUserId &&
                    processedDraft.ObjectiveDraftSubmission == objectiveDraftSubmission;
                objectiveDraftDecision = processedDraft.ObjectiveDraftDecision with
                {
                    HasStateChanged = false,
                    IsAccepted = isSameRequest && processedDraft.ObjectiveDraftDecision.IsAccepted,
                    HasCompletedSelectionFreeCycle = isSameRequest &&
                        processedDraft.ObjectiveDraftDecision.HasCompletedSelectionFreeCycle,
                    RejectionReason = isSameRequest ? processedDraft.ObjectiveDraftDecision.RejectionReason :
                        ObjectiveDraftRejectionReason.SubmissionIdentityReused
                };
            }
            else
            {
                objectiveDraftDecision = ProcessNewObjectiveDraft(
                    matchState, objectiveDraftSubmission, participantUserId);
            }
            return objectiveDraftDecision;
        }

        private static ObjectiveDraftDecision ProcessNewObjectiveDraft(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            ObjectiveDraftRejectionReason draftRejection =
                GetObjectiveDraftIdentityRejection(matchState, objectiveDraftSubmission);
            if (draftRejection == ObjectiveDraftRejectionReason.None)
            {
                draftRejection = ConsumeObjectiveDraftBudget(matchState, participantUserId);
            }
            if (draftRejection == ObjectiveDraftRejectionReason.None &&
                objectiveDraftSubmission.ObjectiveDraftSubmissionId != matchState.CurrentObjectiveDraftSubmissionId)
            {
                draftRejection = ObjectiveDraftRejectionReason.SubmissionExpired;
            }
            bool canRecord = draftRejection == ObjectiveDraftRejectionReason.None;
            if (canRecord)
            {
                draftRejection = GetObjectiveDraftRuleRejection(
                    matchState, objectiveDraftSubmission, participantUserId);
            }
            var objectiveDraftDecision = new ObjectiveDraftDecision
            {
                ObjectiveDraftSubmissionId = objectiveDraftSubmission.ObjectiveDraftSubmissionId,
                RejectionReason = draftRejection,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
            if (draftRejection == ObjectiveDraftRejectionReason.None)
            {
                objectiveDraftDecision = ApplyObjectiveDraftAction(
                    matchState, objectiveDraftSubmission, participantUserId);
            }
            if (objectiveDraftDecision.IsAccepted)
            {
                RetainObjectiveDraftDecision(matchState, participantUserId, new ProcessedObjectiveDraft
                {
                    ParticipantUserId = participantUserId,
                    ObjectiveDraftSubmission = objectiveDraftSubmission,
                    ObjectiveDraftDecision = objectiveDraftDecision
                });
            }
            return objectiveDraftDecision;
        }

        private static ObjectiveDraftRejectionReason GetObjectiveDraftIdentityRejection(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission)
        {
            bool isActionValid = objectiveDraftSubmission.ObjectiveDraftAction == ObjectiveDraftAction.Pass ||
                objectiveDraftSubmission.ObjectiveDraftAction == ObjectiveDraftAction.SelectObjective;
            bool hasValidObjective =
                objectiveDraftSubmission.ObjectiveDraftAction == ObjectiveDraftAction.SelectObjective
                ? objectiveDraftSubmission.SelectedMissionObjectiveId.HasValue &&
                    objectiveDraftSubmission.SelectedMissionObjectiveId != Guid.Empty
                : !objectiveDraftSubmission.SelectedMissionObjectiveId.HasValue;
            bool isIdentityValid = objectiveDraftSubmission.MatchId == matchState.MatchId &&
                objectiveDraftSubmission.MissionAttemptId == matchState.MissionAttempt.MissionAttemptId &&
                objectiveDraftSubmission.ObjectiveDraftSubmissionId != Guid.Empty;
            return isActionValid && hasValidObjective && isIdentityValid ? ObjectiveDraftRejectionReason.None :
                ObjectiveDraftRejectionReason.InvalidSubmission;
        }

        private static ObjectiveDraftRejectionReason ConsumeObjectiveDraftBudget(
            MatchState matchState, int participantUserId)
        {
            MatchActionRequestBudget requestBudget = MatchActionRequestLimits.ConsumeParticipantWindow(
                matchState.ObjectiveDraftBudgetsByParticipant, participantUserId,
                MaximumObjectiveDraftRequestsPerSecond);
            return requestBudget == null ? ObjectiveDraftRejectionReason.RequestLimitReached :
                ObjectiveDraftRejectionReason.None;
        }

        private static void RetainObjectiveDraftDecision(
            MatchState matchState, int participantUserId, ProcessedObjectiveDraft processedDraft)
        {
            if (!matchState.ObjectiveDraftHistoryByParticipant.TryGetValue(participantUserId,
                out Queue<Guid> participantHistory))
            {
                participantHistory = new Queue<Guid>();
                matchState.ObjectiveDraftHistoryByParticipant.Add(participantUserId, participantHistory);
            }
            if (participantHistory.Count >= MaximumRetainedObjectiveDraftDecisionsPerParticipant)
            {
                matchState.ProcessedObjectiveDrafts.Remove(participantHistory.Dequeue());
            }
            Guid submissionId = processedDraft.ObjectiveDraftSubmission.ObjectiveDraftSubmissionId;
            matchState.ProcessedObjectiveDrafts.Add(submissionId, processedDraft);
            participantHistory.Enqueue(submissionId);
        }

        private static ObjectiveDraftRejectionReason GetObjectiveDraftRuleRejection(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            ObjectiveDraftRejectionReason draftRejection = ObjectiveDraftRejectionReason.None;
            MissionAttemptState missionAttempt = matchState.MissionAttempt;
            if (missionAttempt.Phase != MissionAttemptPhase.ObjectiveDrafting)
            {
                draftRejection = ObjectiveDraftRejectionReason.PreparationCompleted;
            }
            else
            {
                draftRejection = GetActiveObjectiveDraftRejection(
                    matchState, objectiveDraftSubmission, participantUserId);
            }
            return draftRejection;
        }

        private static ObjectiveDraftRejectionReason GetActiveObjectiveDraftRejection(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            MissionAttemptState missionAttempt = matchState.MissionAttempt;
            ObjectiveDraftRejectionReason draftRejection = ObjectiveDraftRejectionReason.None;
            if (!MissionAttemptPreparation.CanPrepareMission(missionAttempt.MissionNumber))
            {
                draftRejection = ObjectiveDraftRejectionReason.UnsupportedDraftMode;
            }
            else if (objectiveDraftSubmission.ExpectedMatchStateVersion != matchState.MatchStateVersion)
            {
                draftRejection = ObjectiveDraftRejectionReason.StaleMatchState;
            }
            else if (matchState.ParticipantUserIds[missionAttempt.CurrentObjectiveDraftSeat] != participantUserId)
            {
                draftRejection = ObjectiveDraftRejectionReason.NotDraftTurn;
            }
            else
            {
                draftRejection = ValidateObjectiveDraftChoice(matchState, objectiveDraftSubmission, participantUserId);
            }
            return draftRejection;
        }

        private static ObjectiveDraftRejectionReason ValidateObjectiveDraftChoice(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            MissionAttemptState missionAttempt = matchState.MissionAttempt;
            int selectedCardId = 0;
            matchState.ObjectiveCardIdsByObjectiveId.TryGetValue(
                objectiveDraftSubmission.SelectedMissionObjectiveId ?? Guid.Empty, out selectedCardId);
            var draftContext = new MissionDraftContext
            {
                Definition = MissionCatalog.GetMission(missionAttempt.MissionNumber),
                CurrentObjectives = missionAttempt.Objectives,
                ObjectiveIndex = missionAttempt.Objectives.ToList()
                    .FindIndex(objective => objective.CardId == selectedCardId),
                AttemptingSeat = (byte)Array.IndexOf(matchState.ParticipantUserIds, participantUserId),
                CurrentObjectiveDraftSeat = missionAttempt.CurrentObjectiveDraftSeat,
                CaptainSeat = missionAttempt.CaptainSeat,
                PlayerCount = missionAttempt.PlayerCount,
                RoleConfig = missionAttempt.RoleConfig
            };
            bool isAllowed = objectiveDraftSubmission.ObjectiveDraftAction == ObjectiveDraftAction.Pass
                ? MissionSetupRules.CanPassObjectiveDraft(draftContext)
                : MissionSetupRules.CanDraftObjective(draftContext);
            return isAllowed ? ObjectiveDraftRejectionReason.None : ObjectiveDraftRejectionReason.ObjectiveUnavailable;
        }

        private static ObjectiveDraftDecision ApplyObjectiveDraftAction(
            MatchState matchState, ObjectiveDraftSubmission objectiveDraftSubmission, int participantUserId)
        {
            MissionAttemptState missionAttempt = matchState.MissionAttempt;
            bool hasSelectedObjective =
                objectiveDraftSubmission.ObjectiveDraftAction == ObjectiveDraftAction.SelectObjective;
            if (hasSelectedObjective)
            {
                int selectedCardId = matchState.ObjectiveCardIdsByObjectiveId[
                    objectiveDraftSubmission.SelectedMissionObjectiveId.Value];
                int objectiveIndex = missionAttempt.Objectives.ToList()
                    .FindIndex(objective => objective.CardId == selectedCardId);
                missionAttempt = missionAttempt with
                {
                    Objectives = MissionSetupRules.AssignObjective(missionAttempt.Objectives, objectiveIndex,
                        (byte)Array.IndexOf(matchState.ParticipantUserIds, participantUserId))
                };
            }
            bool hasCompletedCycle = !hasSelectedObjective &&
                missionAttempt.ConsecutiveObjectiveDraftPassCount == missionAttempt.PlayerCount - 1;
            missionAttempt = MissionSetupRules.AdvanceObjectiveDraft(missionAttempt, hasSelectedObjective);
            if (missionAttempt.Objectives.All(objective => objective.AssignedSeat.HasValue))
            {
                missionAttempt = missionAttempt with { Phase = MissionAttemptPhase.PlayingTricks };
            }
            matchState.CommitObjectiveDraft(missionAttempt);
            return new ObjectiveDraftDecision
            {
                ObjectiveDraftSubmissionId = objectiveDraftSubmission.ObjectiveDraftSubmissionId,
                IsAccepted = true,
                HasStateChanged = true,
                HasCompletedSelectionFreeCycle = hasCompletedCycle,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
        }
    }
}
