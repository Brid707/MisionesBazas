using System.Collections.Generic;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;

namespace Services.Mapping
{
    internal static class DistressSignalMapper
    {
        private static readonly IReadOnlyDictionary<DistressPassDirection, PassDirection> DirectionsByContract =
            new Dictionary<DistressPassDirection, PassDirection>
            {
                { DistressPassDirection.None, PassDirection.None },
                { DistressPassDirection.Left, PassDirection.Left },
                { DistressPassDirection.Right, PassDirection.Right }
            };

        private static readonly IReadOnlyDictionary<DistressSignalRejection, DistressSignalFailureReason>
            FailuresByRejection = new Dictionary<DistressSignalRejection, DistressSignalFailureReason>
            {
                { DistressSignalRejection.None, DistressSignalFailureReason.None },
                { DistressSignalRejection.InvalidSubmission, DistressSignalFailureReason.InvalidSubmission },
                { DistressSignalRejection.MatchUnavailable, DistressSignalFailureReason.MatchUnavailable },
                { DistressSignalRejection.ParticipantNotAllowed, DistressSignalFailureReason.ParticipantNotAllowed },
                { DistressSignalRejection.WrongMissionAttempt, DistressSignalFailureReason.WrongMissionAttempt },
                { DistressSignalRejection.MissionPreparationRequired,
                    DistressSignalFailureReason.MissionPreparationRequired },
                { DistressSignalRejection.MissionAttemptFinished, DistressSignalFailureReason.MissionAttemptFinished },
                { DistressSignalRejection.DistressAlreadyUsed, DistressSignalFailureReason.DistressAlreadyUsed },
                { DistressSignalRejection.TrickAlreadyStarted, DistressSignalFailureReason.TrickAlreadyStarted },
                { DistressSignalRejection.RadioAlreadyUsed, DistressSignalFailureReason.RadioAlreadyUsed },
                { DistressSignalRejection.CardNotInHand, DistressSignalFailureReason.CardNotInHand },
                { DistressSignalRejection.SpecialCardNotAllowed, DistressSignalFailureReason.SpecialCardNotAllowed },
                { DistressSignalRejection.InvalidStepTransition, DistressSignalFailureReason.InvalidStepTransition },
                { DistressSignalRejection.OperationUnavailable, DistressSignalFailureReason.OperationUnavailable }
            };

        internal static DistressSignalRequest MapSubmission(DistressSignalSubmission submission)
        {
            DirectionsByContract.TryGetValue(submission.SelectedDirection, out PassDirection selectedDirection);
            return new DistressSignalRequest
            {
                MatchId = submission.MatchId,
                LobbyCode = submission.LobbyCode,
                MissionAttemptId = submission.MissionAttemptId,
                CardIdToPass = submission.CardIdToPass,
                SelectedDirection = selectedDirection,
                IsVoteAccepted = submission.IsVoteAccepted,
                ActionType = submission.ActionType
            };
        }

        internal static DistressSignalFailureReason MapRejection(DistressSignalRejection rejection)
        {
            return FailuresByRejection.TryGetValue(rejection, out DistressSignalFailureReason reason)
                ? reason
                : DistressSignalFailureReason.InvalidSubmission;
        }
    }
}
