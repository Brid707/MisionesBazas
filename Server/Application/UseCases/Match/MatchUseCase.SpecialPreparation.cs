using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private const int MaximumPreparationRequestsPerSecond = 4;
        private const int MaximumPreparationLobbyCodeLength = 16;

        public MissionPreparationCommit ProcessMissionPreparation(MissionPreparationRequest request, int
            participantUserId)
        {
            var commit = RejectPreparation(request, MissionPreparationRejection.InvalidSubmission);
            if (request != null && !string.IsNullOrWhiteSpace(request.LobbyCode) &&
                request.LobbyCode.Length <= MaximumPreparationLobbyCodeLength)
            {
                MatchState matchState = _matchStateStore.FindMatch(request.LobbyCode);
                commit = RejectPreparation(request, MissionPreparationRejection.MatchUnavailable);
                if (matchState != null)
                {
                    lock (matchState)
                    {
                        commit = ResolveMissionPreparation(matchState, request, participantUserId);
                    }
                }
            }
            return commit;
        }

        private static MissionPreparationCommit ResolveMissionPreparation(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationRejection rejection = ValidatePreparationIdentity(matchState, request, participantUserId);
            MissionPreparationCommit commit;
            if (rejection != MissionPreparationRejection.None)
            {
                commit = RejectPreparation(request, rejection);
            }
            else if (matchState.ProcessedPreparationSubmissions.TryGetValue(request.MissionPreparationSubmissionId,
                out ProcessedMissionPreparation previous))
            {
                commit = previous.ParticipantUserId == participantUserId && previous.Request == request
                    ? previous.Commit with { HasStateChanged = false }
                    : RejectPreparation(request, MissionPreparationRejection.SubmissionIdentityReused);
            }
            else
            {
                commit = ProcessNewPreparation(matchState, request, participantUserId);
            }
            return commit;
        }

        private static MissionPreparationRejection ValidatePreparationIdentity(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationRejection rejection = MissionPreparationRejection.None;
            if (!matchState.ParticipantUserIds.Contains(participantUserId))
            {
                rejection = MissionPreparationRejection.ParticipantNotAllowed;
            }
            else if (request.MatchId != matchState.MatchId || request.MissionPreparationSubmissionId == Guid.Empty ||
                !Enum.IsDefined(typeof(MissionPreparationAction), request.Action) || !HasValidPreparationShape(request))
            {
                rejection = MissionPreparationRejection.InvalidSubmission;
            }
            else if (request.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                rejection = MissionPreparationRejection.WrongMissionAttempt;
            }
            return rejection;
        }

        private static bool HasValidPreparationShape(MissionPreparationRequest request)
        {
            return request.Action == MissionPreparationAction.AssignRole
                ? request.SelectedParticipantUserId != 0 && request.Response == BlindObjectiveCapableResponse.Pending
                : request.SelectedParticipantUserId == 0 && (request.Response == BlindObjectiveCapableResponse.Yes ||
                    request.Response == BlindObjectiveCapableResponse.No);
        }

        private static MissionPreparationCommit ProcessNewPreparation(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationRejection rejection = ValidatePreparationWindow(matchState, request, participantUserId);
            MissionPreparationCommit commit = RejectPreparation(request, rejection);
            if (rejection == MissionPreparationRejection.None)
            {
                commit = CommitRequestedPreparation(matchState, request, participantUserId);
            }
            return commit;
        }

        private static MissionPreparationCommit CommitRequestedPreparation(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationCommit commit;
            if (request.Action == MissionPreparationAction.AssignRole)
            {
                commit = AssignRequestedMissionRole(matchState, request, participantUserId);
            }
            else
            {
                commit = RecordBlindResponse(matchState, request, participantUserId);
            }
            return commit;
        }

        private static MissionPreparationRejection ValidatePreparationWindow(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            MissionPreparationRejection rejection = MissionPreparationRejection.RequestLimitReached;
            if (MatchActionRequestLimits.ConsumeParticipantWindow(matchState.PreparationBudgetsByParticipant,
                participantUserId, MaximumPreparationRequestsPerSecond) != null)
            {
                rejection = ValidatePreparationStage(matchState, request);
            }
            return rejection;
        }

        private static MissionPreparationRejection ValidatePreparationStage(MatchState matchState,
            MissionPreparationRequest request)
        {
            MissionPreparationRejection rejection = MissionPreparationRejection.None;
            if (matchState.MissionAttempt.Phase != MissionAttemptPhase.RoleAndPreparation ||
                request.MissionPreparationStageId != matchState.MissionPreparationStageId)
            {
                rejection = MissionPreparationRejection.StageMismatch;
            }
            else
            {
                bool isCurrentVersion = request.Action == MissionPreparationAction.AssignRole
                    ? request.ExpectedMatchStateVersion == matchState.MatchStateVersion
                    : request.ExpectedMatchStateVersion >= matchState.PreparationStageOpenedVersion &&
                        request.ExpectedMatchStateVersion <= matchState.MatchStateVersion;
                rejection = isCurrentVersion ? MissionPreparationRejection.None :
                    MissionPreparationRejection.StaleMatchState;
            }
            return rejection;
        }

        private static MissionPreparationCommit AssignRequestedMissionRole(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            int actorSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            int targetSeat = Array.IndexOf(matchState.ParticipantUserIds, request.SelectedParticipantUserId);
            var context = CreateRoleContext(matchState, actorSeat, targetSeat);
            MissionPreparationRejection rejection = MissionPreparationRejection.InvalidTarget;
            MissionPreparationCommit commit = null;
            if (actorSeat != matchState.MissionCaptainSeat)
            {
                rejection = MissionPreparationRejection.CaptainRequired;
            }
            else if (MissionSetupRules.IsBlindObjectiveAssignmentRule(context.Definition.SpecialRule) &&
                !MissionSetupRules.AreAllBlindResponsesRecorded(matchState.BlindResponsesBySeat,
                    matchState.ParticipantUserIds.Length, (byte)matchState.MissionCaptainSeat))
            {
                rejection = MissionPreparationRejection.ResponsesPending;
            }
            else if (MissionSpecialPreparationRules.CanAssignRole(context))
            {
                commit = matchState.CommitSpecialPreparation(request, participantUserId, new SpecialPreparationChange
                {
                    UpdatedAttempt = MissionSpecialPreparationRules.AssignRole(context),
                    ResponsesBySeat = matchState.BlindResponsesBySeat,
                    HasStageChanged = true
                });
            }
            return commit ?? RejectPreparation(request, rejection);
        }

        internal static MissionRoleAssignmentContext CreateRoleContext(MatchState matchState, int actorSeat, int
            targetSeat)
        {
            return new MissionRoleAssignmentContext
            {
                Attempt = matchState.MissionAttempt,
                Definition = MissionCatalog.GetMission(matchState.MissionAttempt.MissionNumber),
                ActingParticipantSeat = actorSeat,
                SelectedParticipantSeat = targetSeat,
                ResponsesBySeat = matchState.BlindResponsesBySeat
            };
        }

        private static MissionPreparationCommit RecordBlindResponse(MatchState matchState,
            MissionPreparationRequest request, int participantUserId)
        {
            byte seat = (byte)Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            MissionPreparationRejection rejection = MissionPreparationRejection.InvalidSubmission;
            bool isBlindMission = MissionSetupRules.IsBlindObjectiveAssignmentRule(
                MissionCatalog.GetMission(matchState.MissionAttempt.MissionNumber).SpecialRule);
            if (isBlindMission && seat != matchState.MissionCaptainSeat)
            {
                rejection = matchState.BlindResponsesBySeat.ContainsKey(seat)
                    ? MissionPreparationRejection.AlreadyAnswered : MissionPreparationRejection.None;
            }
            var commit = RejectPreparation(request, rejection);
            if (rejection == MissionPreparationRejection.None)
            {
                var responses = matchState.BlindResponsesBySeat.ToDictionary(entry => entry.Key, entry => entry.Value);
                responses.Add(seat, request.Response);
                bool isComplete = MissionSetupRules.AreAllBlindResponsesRecorded(responses,
                    matchState.ParticipantUserIds.Length, (byte)matchState.MissionCaptainSeat);
                commit = matchState.CommitSpecialPreparation(request, participantUserId, new SpecialPreparationChange
                {
                    UpdatedAttempt = matchState.MissionAttempt,
                    ResponsesBySeat = responses,
                    HasStageChanged = isComplete
                });
            }
            return commit;
        }

        private static MissionPreparationCommit RejectPreparation(MissionPreparationRequest request,
            MissionPreparationRejection rejection)
        {
            return new MissionPreparationCommit
            {
                MissionPreparationSubmissionId = request?.MissionPreparationSubmissionId ?? Guid.Empty,
                Rejection = rejection
            };
        }
    }
}
