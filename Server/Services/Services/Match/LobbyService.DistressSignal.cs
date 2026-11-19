using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        public DistressSignalConfirmation SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength ||
                !Enum.IsDefined(typeof(DistressSignalActionType), submission.ActionType) ||
                submission.ActionType == DistressSignalActionType.None ||
                !Enum.IsDefined(typeof(DistressPassDirection), submission.SelectedDirection))
            {
                throw CreateDistressFault(DistressSignalFailureReason.InvalidSubmission);
            }
            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);
            DistressSignalCommit result = ExecuteDistressSignal(submission, participantUserId);
            if (result.Rejection != DistressSignalRejection.None)
            {
                throw CreateDistressFault(DistressSignalMapper.MapRejection(result.Rejection));
            }
            if (result.HasStateChanged)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(result.CommittedMatchStateVersion));
            }
            return new DistressSignalConfirmation
            {
                IsExecuted = result.IsExecuted,
                CommittedMatchStateVersion = result.CommittedMatchStateVersion
            };
        }

        private DistressSignalCommit ExecuteDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            DistressSignalCommit result;
            try
            {
                result = _lobbyUseCase.Match.SubmitDistressSignal(
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
            return result;
        }

        private static FaultException<DistressSignalFault> CreateDistressFault(DistressSignalFailureReason reason)
        {
            return new FaultException<DistressSignalFault>(new DistressSignalFault { FailureReason = reason });
        }
    }
}
