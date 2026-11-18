using System;
using System.Security.Cryptography;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        private const string MissionRetryPreparationUnavailableCode = "MissionRetryPreparationUnavailable";

        public MissionRetryDecision ConfirmMissionRetry(MissionRetrySubmission submission, int participantUserId)
        {
            if (submission == null || string.IsNullOrWhiteSpace(submission.LobbyCode) ||
                submission.LobbyCode.Length > MaximumMatchActionLobbyCodeLength)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = FaultInvalidSubmission
                });
            }
            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(submission.LobbyCode, participantUserId);
            MissionRetryConfirmation confirmation = ProcessMissionRetry(submission, participantUserId);
            if (confirmation.HasStateChanged)
            {
                BroadcastToRoom(submission.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(confirmation.CommittedMatchStateVersion));
            }
            return MissionRetryMapper.MapDecision(confirmation);
        }

        private MissionRetryConfirmation ProcessMissionRetry(MissionRetrySubmission submission, int participantUserId)
        {
            MissionRetryConfirmation confirmation;
            try
            {
                confirmation = _lobbyUseCase.Match.ConfirmMissionRetry(
                    MissionRetryMapper.MapRequest(submission), participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw CreateMatchOperationFault(ex, MissionRetryPreparationUnavailableCode);
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMatchOperationFault(ex, MissionRetryPreparationUnavailableCode);
            }
            catch (CryptographicException ex)
            {
                throw CreateMatchOperationFault(ex, MissionRetryPreparationUnavailableCode);
            }
            return confirmation;
        }
    }
}
