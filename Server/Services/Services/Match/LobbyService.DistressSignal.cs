using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        /// <summary>
        /// Submits or votes on a distress signal action for a participant in the active match.
        /// </summary>
        /// <param name="submission">The distress signal action details and card pass selection.</param>
        /// <param name="participantUserId">The identifier of the user issuing the submission.</param>
        /// <returns>
        /// The confirmation indicating whether the action was executed and the committed state version.
        /// </returns>
        /// <exception cref="FaultException{DistressSignalFault}">
        /// Thrown when submission is invalid or rejected by business rules.
        /// </exception>
        /// <exception cref="FaultException{MatchAccessFault}">
        /// Thrown when participant is unauthorized or the operation is unavailable.
        /// </exception>
        public DistressSignalConfirmation SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            if (!IsSubmissionValid(submission))
            {
                throw CreateDistressFault(DistressSignalFailureReason.InvalidSubmission);
            }

            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);

            DistressSignalCommit signalCommit = ExecuteDistressSignal(submission, participantUserId);

            if (signalCommit.Rejection != DistressSignalRejection.None)
            {
                throw CreateDistressFault(DistressSignalMapper.MapRejection(signalCommit.Rejection));
            }

            if (signalCommit.HasStateChanged)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(signalCommit.CommittedMatchStateVersion));
            }

            return new DistressSignalConfirmation
            {
                IsExecuted = signalCommit.IsExecuted,
                CommittedMatchStateVersion = signalCommit.CommittedMatchStateVersion
            };
        }

        private DistressSignalCommit ExecuteDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            DistressSignalCommit signalCommit;

            try
            {
                signalCommit = _lobbyUseCase.Match.SubmitDistressSignal(
                    DistressSignalMapper.MapSubmission(submission), participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(DistressSignalFailureReason.OperationUnavailable));
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(DistressSignalFailureReason.OperationUnavailable));
            }

            return signalCommit;
        }

        private static bool IsSubmissionValid(DistressSignalSubmission submission)
        {
            return submission is not null
                && !string.IsNullOrWhiteSpace(submission.LobbyCode)
                && submission.LobbyCode.Length <= MaximumMatchActionLobbyCodeLength
                && Enum.IsDefined(typeof(DistressSignalActionType), submission.ActionType)
                && submission.ActionType != DistressSignalActionType.None
                && Enum.IsDefined(typeof(DistressPassDirection), submission.SelectedDirection);
        }

        private static FaultException<DistressSignalFault> CreateDistressFault(DistressSignalFailureReason reason)
        {
            return new FaultException<DistressSignalFault>(new DistressSignalFault { FailureReason = reason });
        }
    }
}
