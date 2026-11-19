using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Outcome of evaluating a completed trick against mission objectives and special rules.
    /// </summary>
    public sealed record MissionEvaluationResult
    {
        public MissionAttemptStatus OverallStatus { get; init; }

        public IReadOnlyList<MissionObjective> UpdatedObjectives { get; init; }

        public string Message { get; init; }

        public MissionEvaluationFailureCode FailureCode { get; init; }

        private static readonly IReadOnlyDictionary<string, MissionEvaluationFailureCode> s_failureCodes =
            new Dictionary<string, MissionEvaluationFailureCode>
            {
                { MissionFailureReasons.ObjectiveCapturedByWrongSeat,
                    MissionEvaluationFailureCode.ObjectiveCapturedByWrongSeat },
                { MissionFailureReasons.MultipleOrderedTokensInSameTrick,
                    MissionEvaluationFailureCode.MultipleOrderedTokensInSameTrick },
                { MissionFailureReasons.MultipleArrowTokensInSameTrick,
                    MissionEvaluationFailureCode.MultipleArrowTokensInSameTrick },
                { MissionFailureReasons.OmegaSimultaneousCompletion,
                    MissionEvaluationFailureCode.OmegaSimultaneousCompletion },
                { MissionFailureReasons.PrecedingOrderTokenNotCompleted,
                    MissionEvaluationFailureCode.PrecedingOrderTokenNotCompleted },
                { MissionFailureReasons.PrecedingArrowTokenNotCompleted,
                    MissionEvaluationFailureCode.PrecedingArrowTokenNotCompleted },
                { MissionFailureReasons.OmegaObjectiveNotCompletedLast,
                    MissionEvaluationFailureCode.OmegaObjectiveNotCompletedLast },
                { MissionFailureReasons.ObjectivesIncompleteAtMissionEnd,
                    MissionEvaluationFailureCode.ObjectivesIncompleteAtMissionEnd },
                { MissionFailureReasons.Mission48OmegaNotInLastTrick,
                    MissionEvaluationFailureCode.Mission48OmegaNotInLastTrick },
                { MissionFailureReasons.Mission09NoTrickWonWithOne,
                    MissionEvaluationFailureCode.NormalOneDidNotWinTrick },
                { MissionFailureReasons.Mission13SpecialCardLostTrick,
                    MissionEvaluationFailureCode.SpecialCardLostTrick },
                { MissionFailureReasons.Mission13NotAllSpecialCardsWon,
                    MissionEvaluationFailureCode.SpecialCardsDidNotWinAllRequiredTricks },
                { MissionFailureReasons.Mission16TrickWonWithNine, MissionEvaluationFailureCode.NormalNineWonTrick },
                { MissionFailureReasons.Mission05AllPlayersWonTrick,
                    MissionEvaluationFailureCode.AllParticipantsWonAtLeastOneTrick },
                { MissionFailureReasons.Mission26LessTwoTricksWonWithOne,
                    MissionEvaluationFailureCode.InsufficientNormalOneWinningTricks },
                { MissionFailureReasons.Mission29TrickDifferenceExceeded,
                    MissionEvaluationFailureCode.WonTrickDifferenceExceeded },
                { MissionFailureReasons.Mission33RoleUnassigned,
                    MissionEvaluationFailureCode.SingleTrickWinnerUnassigned },
                { MissionFailureReasons.Mission33WonWithSpecialCard,
                    MissionEvaluationFailureCode.SelectedParticipantWonWithSpecialCard },
                { MissionFailureReasons.Mission33WonMultipleTricks,
                    MissionEvaluationFailureCode.SelectedParticipantWonMultipleTricks },
                { MissionFailureReasons.Mission33DidNotWinExactlyOneTrick,
                    MissionEvaluationFailureCode.SelectedParticipantDidNotWinExactlyOneTrick },
                { MissionFailureReasons.Mission34CaptainDidNotWinFirstTrick,
                    MissionEvaluationFailureCode.CaptainDidNotWinFirstTrick },
                { MissionFailureReasons.Mission34CaptainDidNotWinLastTrick,
                    MissionEvaluationFailureCode.CaptainDidNotWinLastTrick },
                { MissionFailureReasons.Mission41RoleUnassigned,
                    MissionEvaluationFailureCode.FirstAndLastWinnerUnassigned },
                { MissionFailureReasons.Mission41FirstTrickNotWonBySelected,
                    MissionEvaluationFailureCode.FirstTrickWonByWrongParticipant },
                { MissionFailureReasons.Mission41FirstTrickWonWithSpecial,
                    MissionEvaluationFailureCode.FirstTrickWonWithSpecialCard },
                { MissionFailureReasons.Mission41IntermediateTrickWonBySelected,
                    MissionEvaluationFailureCode.IntermediateTrickWonBySelectedParticipant },
                { MissionFailureReasons.Mission41LastTrickNotWonBySelected,
                    MissionEvaluationFailureCode.LastTrickWonByWrongParticipant },
                { MissionFailureReasons.Mission41LastTrickWonWithSpecial,
                    MissionEvaluationFailureCode.LastTrickWonWithSpecialCard },
                { MissionFailureReasons.Mission44SpecialOrderViolated,
                    MissionEvaluationFailureCode.SpecialCardWinningOrderViolated },
                { MissionFailureReasons.Mission46HeartNineUnidentified,
                    MissionEvaluationFailureCode.HeartNineOwnerUnidentified },
                { MissionFailureReasons.Mission46HeartCapturedByWrongSeat,
                    MissionEvaluationFailureCode.HeartCapturedByWrongParticipant },
                { MissionFailureReasons.Mission46HeartsIncomplete,
                    MissionEvaluationFailureCode.HeartCardsNotAllCaptured },
                { MissionFailureReasons.Mission50RolesUnassigned,
                    MissionEvaluationFailureCode.TrickDistributionUnassigned },
                { MissionFailureReasons.Mission50FirstFourTricksWrongWinner,
                    MissionEvaluationFailureCode.InitialTricksWonByWrongParticipant },
                { MissionFailureReasons.Mission50FirstFourWinnerWonExtra,
                    MissionEvaluationFailureCode.InitialTrickWinnerWonExtra },
                { MissionFailureReasons.Mission50LastTrickWinnerWonEarly,
                    MissionEvaluationFailureCode.FinalTrickWinnerWonEarly },
                { MissionFailureReasons.Mission50LastTrickWrongWinner,
                    MissionEvaluationFailureCode.FinalTrickWonByWrongParticipant },
                { MissionFailureReasons.Mission50RemainingPlayerWonNoTrick,
                    MissionEvaluationFailureCode.RemainingParticipantWonNoTrick },
                { MissionFailureReasons.Mission48PendingNonOmegaBeforeLastTrick,
                    MissionEvaluationFailureCode.Mission48PendingNonOmegaBeforeLastTrick }
            };

        public static MissionEvaluationResult Success(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Succeeded,
                UpdatedObjectives = objectives.ToArray(),
                Message = message
            };
        }

        public static MissionEvaluationResult InProgress(IReadOnlyList<MissionObjective> objectives, string message = null)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.InProgress,
                UpdatedObjectives = objectives.ToArray(),
                Message = message
            };
        }

        public static MissionEvaluationResult Fail(IReadOnlyList<MissionObjective> objectives, string reason)
        {
            return new MissionEvaluationResult
            {
                OverallStatus = MissionAttemptStatus.Failed,
                UpdatedObjectives = objectives.ToArray(),
                FailureCode = GetFailureCode(reason),
                Message = reason
            };
        }
        private static MissionEvaluationFailureCode GetFailureCode(string failureReason)
        {
            MissionEvaluationFailureCode failureCode = MissionEvaluationFailureCode.SpecialMissionConstraint;
            if (failureReason != null && s_failureCodes.TryGetValue(failureReason, out var knownFailureCode))
            {
                failureCode = knownFailureCode;
            }
            return failureCode;
        }
    }
}
