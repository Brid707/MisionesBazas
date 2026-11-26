using System;
using System.Linq;
using AppModels = Application.Models;
using Contract = Services.DataContracts;

namespace Services.Mapping
{
    /// <summary>Translates pure application match snapshots and plays into WCF data contracts.</summary>
    internal static class MatchGameplayMapper
    {
        internal static AppModels.CardPlaySubmission MapCardPlaySubmission(Contract.CardPlaySubmission submission)
        {
            if (submission == null)
            {
                return null;
            }
            return new AppModels.CardPlaySubmission
            {
                MissionAttemptId = submission.MissionAttemptId,
                LobbyCode = submission.LobbyCode,
                MatchId = submission.MatchId,
                CardPlaySubmissionId = submission.CardPlaySubmissionId,
                ExpectedMatchStateVersion = submission.ExpectedMatchStateVersion,
                CardId = submission.CardId
            };
        }

        internal static Contract.CardPlayDecision MapCardPlayDecision(AppModels.CardPlayDecision decision)
        {
            if (decision == null)
            {
                return null;
            }
            return new Contract.CardPlayDecision
            {
                CardPlaySubmissionId = decision.CardPlaySubmissionId,
                IsAccepted = decision.IsAccepted,
                RejectionReason = (Contract.MatchRejectionReason)(int)decision.RejectionReason,
                CommittedMatchStateVersion = decision.CommittedMatchStateVersion
            };
        }

        internal static Contract.PlayerMatchSnapshot MapSnapshot(AppModels.PlayerMatchSnapshot snapshot)
        {
            if (snapshot == null)
            {
                return null;
            }
            return new Contract.PlayerMatchSnapshot
            {
                MatchId = snapshot.MatchId,
                MatchStateVersion = snapshot.MatchStateVersion,
                OwnHandCardIds = snapshot.OwnHandCardIds,
                ParticipantUserIds = snapshot.ParticipantUserIds,
                RemainingHandCardCounts = snapshot.RemainingHandCardCounts,
                CurrentTurnPlayerUserId = snapshot.CurrentTurnPlayerUserId,
                MissionCaptainUserId = snapshot.MissionCaptainUserId,
                CurrentTrickNumber = snapshot.CurrentTrickNumber,
                MaximumMissionTrickCount = snapshot.MaximumMissionTrickCount,
                IsDealCompleted = snapshot.IsDealCompleted,
                CurrentTrickCardPlays = snapshot.CurrentTrickCardPlays?.Select(MapMatchCardPlay).ToArray(),
                LastCompletedTrickCardPlays = snapshot.LastCompletedTrickCardPlays?.Select(MapMatchCardPlay).ToArray(),
                LastTrickWinnerUserId = snapshot.LastTrickWinnerUserId,
                MissionPreparation = MapPreparation(snapshot.MissionPreparation),
                CapturedCardsByPlayer = snapshot.CapturedCardsByPlayer?.Select(MapCapturedCards).ToArray(),
                MissionEvaluation = MapEvaluation(snapshot.MissionEvaluation),
                MissionRetry = MapRetry(snapshot.MissionRetry),
                MissionTransition = MapTransition(snapshot.MissionTransition),
                RadioCommunications = snapshot.RadioCommunications?.Select(MapRadioCommunication).ToArray(),
                RadioMode = (Contract.RadioCommunicationMode)(int)snapshot.RadioMode,
                MissionConditionProgress = MapConditionProgress(snapshot.MissionConditionProgress),
                OwnRadioAvailability = MapRadioAvailability(snapshot.OwnRadioAvailability),
                DistressSignal = MapDistressSignal(snapshot.DistressSignal)
            };
        }

        private static Contract.MatchCardPlay MapMatchCardPlay(AppModels.MatchCardPlay play)
        {
            return new Contract.MatchCardPlay
            {
                PlayerUserId = play.PlayerUserId,
                CardId = play.CardId
            };
        }

        private static Contract.PlayerCapturedCardsSnapshot MapCapturedCards(AppModels.PlayerCapturedCardsSnapshot captured)
        {
            return new Contract.PlayerCapturedCardsSnapshot
            {
                PlayerUserId = captured.PlayerUserId,
                WonTrickCount = captured.WonTrickCount,
                WonCardIds = captured.WonCardIds
            };
        }

        private static Contract.PlayerMissionPreparationSnapshot MapPreparation(
            AppModels.PlayerMissionPreparationSnapshot preparation)
        {
            if (preparation == null)
            {
                return null;
            }
            return new Contract.PlayerMissionPreparationSnapshot
            {
                AvailableObjectiveDraftSubmissionId = preparation.AvailableObjectiveDraftSubmissionId,
                MissionAttemptId = preparation.MissionAttemptId,
                MissionNumber = preparation.MissionNumber,
                IsPreparationComplete = preparation.IsPreparationComplete,
                CurrentObjectiveDraftPlayerUserId = preparation.CurrentObjectiveDraftPlayerUserId,
                Objectives = preparation.Objectives?.Select(MapObjective).ToArray(),
                Stage = (Contract.MissionPreparationStage)(int)preparation.Stage,
                MissionPreparationStageId = preparation.MissionPreparationStageId,
                EligibleRoleParticipantUserIds = preparation.EligibleRoleParticipantUserIds,
                CanRespondToBlindObjectives = preparation.CanRespondToBlindObjectives,
                BlindObjectiveResponses = preparation.BlindObjectiveResponses?.Select(MapBlindResponse).ToArray(),
                SilencedParticipantUserId = preparation.SilencedParticipantUserId,
                SoleObjectiveAssigneeUserId = preparation.SoleObjectiveAssigneeUserId,
                SingleTrickWinnerParticipantUserId = preparation.SingleTrickWinnerParticipantUserId,
                FirstAndLastTrickWinnerParticipantUserId = preparation.FirstAndLastTrickWinnerParticipantUserId,
                FirstFourTricksWinnerParticipantUserId = preparation.FirstFourTricksWinnerParticipantUserId,
                LastTrickWinnerParticipantUserId = preparation.LastTrickWinnerParticipantUserId,
                HeartNineOwnerParticipantUserId = preparation.HeartNineOwnerParticipantUserId,
                RequiredHeartCaptureParticipantUserId = preparation.RequiredHeartCaptureParticipantUserId,
                CanIdentifyHeartNineOwnership = preparation.CanIdentifyHeartNineOwnership
            };
        }

        private static Contract.MissionObjectiveSnapshot MapObjective(AppModels.MissionObjectiveSnapshot objective)
        {
            return new Contract.MissionObjectiveSnapshot
            {
                MissionObjectiveId = objective.MissionObjectiveId,
                CardId = objective.CardId,
                Token = (Contract.MissionObjectiveToken)(int)objective.Token,
                AssignedPlayerUserId = objective.AssignedPlayerUserId,
                IsRevealed = objective.IsRevealed,
                Status = (Contract.MissionObjectiveStatus)(int)objective.Status,
                CompletedAtTrickNumber = objective.CompletedAtTrickNumber
            };
        }

        private static Contract.BlindObjectiveParticipantSnapshot MapBlindResponse(
            AppModels.BlindObjectiveParticipantSnapshot participant)
        {
            return new Contract.BlindObjectiveParticipantSnapshot
            {
                ParticipantUserId = participant.ParticipantUserId,
                Response = (Contract.BlindObjectiveResponse)(int)participant.Response
            };
        }

        private static Contract.MissionEvaluationSnapshot MapEvaluation(AppModels.MissionEvaluationSnapshot evaluation)
        {
            if (evaluation == null)
            {
                return null;
            }
            return new Contract.MissionEvaluationSnapshot
            {
                MissionAttemptId = evaluation.MissionAttemptId,
                LastEvaluatedTrickNumber = evaluation.LastEvaluatedTrickNumber,
                MissionAttemptStatus = (Contract.MissionAttemptEvaluationStatus)(int)evaluation.MissionAttemptStatus,
                MissionFailureReason = (Contract.MissionEvaluationFailureReason)(int)evaluation.MissionFailureReason
            };
        }

        private static Contract.MissionRetrySnapshot MapRetry(AppModels.MissionRetrySnapshot retry)
        {
            if (retry == null)
            {
                return null;
            }
            return new Contract.MissionRetrySnapshot
            {
                MissionAttemptId = retry.MissionAttemptId,
                AttemptNumber = retry.AttemptNumber,
                IsRetryAvailable = retry.IsRetryAvailable,
                ReadyParticipantUserIds = retry.ReadyParticipantUserIds,
                AvailableMissionRetrySubmissionId = retry.AvailableMissionRetrySubmissionId,
                Status = (Contract.MissionRetryStatus)(int)retry.Status,
                MissionRetryScheduleId = retry.MissionRetryScheduleId,
                RemainingDelayMilliseconds = retry.RemainingDelayMilliseconds,
                MissingParticipantUserIds = retry.MissingParticipantUserIds
            };
        }

        private static Contract.MissionTransitionSnapshot MapTransition(AppModels.MissionTransitionSnapshot transition)
        {
            if (transition == null)
            {
                return null;
            }
            return new Contract.MissionTransitionSnapshot
            {
                MissionAttemptId = transition.MissionAttemptId,
                AttemptNumber = transition.AttemptNumber,
                Status = (Contract.MissionTransitionStatus)(int)transition.Status,
                Kind = (Contract.MissionTransitionKind)(int)transition.Kind,
                MissionTransitionScheduleId = transition.MissionTransitionScheduleId,
                RemainingDelayMilliseconds = transition.RemainingDelayMilliseconds,
                MissingParticipantUserIds = transition.MissingParticipantUserIds,
                DestinationMissionNumber = transition.DestinationMissionNumber,
                TargetMissionCount = transition.TargetMissionCount
            };
        }

        private static Contract.PlayerRadioCommunicationSnapshot MapRadioCommunication(
            AppModels.PlayerRadioCommunicationSnapshot communication)
        {
            return new Contract.PlayerRadioCommunicationSnapshot
            {
                ParticipantUserId = communication.ParticipantUserId,
                CommunicatedCardId = communication.CommunicatedCardId,
                Marker = (Contract.RadioCommunicationMarker)(int)communication.Marker,
                HasCommunicatedCardBeenPlayed = communication.HasCommunicatedCardBeenPlayed
            };
        }

        private static Contract.MissionConditionProgressSnapshot MapConditionProgress(
            AppModels.MissionConditionProgressSnapshot progress)
        {
            if (progress == null)
            {
                return null;
            }
            return new Contract.MissionConditionProgressSnapshot
            {
                TricksWonWithNormalOneCount = progress.TricksWonWithNormalOneCount,
                SpecialWinningCardIds = progress.SpecialWinningCardIds,
                CapturedHeartCardCount = progress.CapturedHeartCardCount
            };
        }

        private static Contract.RadioAvailabilitySnapshot MapRadioAvailability(
            AppModels.RadioAvailabilitySnapshot availability)
        {
            if (availability == null)
            {
                return null;
            }
            return new Contract.RadioAvailabilitySnapshot
            {
                IsAvailable = availability.IsAvailable,
                FailureReason = (Contract.RadioCommunicationFailureReason)(int)availability.FailureReason
            };
        }

        private static Contract.DistressSignalSnapshot MapDistressSignal(AppModels.DistressSignalSnapshot distress)
        {
            if (distress == null)
            {
                return null;
            }
            return new Contract.DistressSignalSnapshot
            {
                HasUsedDistressSignal = distress.HasUsedDistressSignal,
                IsInProgress = distress.IsInProgress,
                AgreedDirection = (Contract.DistressPassDirection)(int)distress.AgreedDirection,
                SubmittedParticipantUserIds = distress.SubmittedParticipantUserIds,
                InitiatorUserId = distress.InitiatorUserId,
                InitiatorPlayerName = distress.InitiatorPlayerName,
                HasBeenRejected = distress.HasBeenRejected,
                CurrentStep = (Contract.DistressSignalPhase)(int)distress.CurrentStep,
                VotedYesUserIds = distress.VotedYesUserIds,
                LeftDirectionVotesCount = distress.LeftDirectionVotesCount,
                RightDirectionVotesCount = distress.RightDirectionVotesCount,
                DirectionVotedUserIds = distress.DirectionVotedUserIds
            };
        }
    }
}
