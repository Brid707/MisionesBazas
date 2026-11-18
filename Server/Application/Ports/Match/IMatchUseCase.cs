using System;
using Gameplay;

namespace Application.Ports
{
    /// <summary>Coordinates authoritative dealing, private snapshots and atomic card plays.</summary>
    public interface IMatchUseCase
    {
        Application.Models.ObjectiveDraftDecision ProcessObjectiveDraftAction(
            Application.Models.ObjectiveDraftSubmission submission, int participantUserId);
        Application.Models.MissionRetryConfirmation ConfirmMissionRetry(
            Application.Models.MissionRetryRequest missionRetryRequest, int participantUserId);
        System.Collections.Generic.IReadOnlyList<Application.Models.MissionRetryWork> TakeDueMissionRetries(
            int maximumPreparations);
        Application.Models.MissionRetryExecutionResult ExecuteScheduledMissionRetry(
            Application.Models.MissionRetryWork retryWork, System.Threading.CancellationToken cancellationToken);
        Application.Models.MissionRetryExecutionResult ReleaseMissionRetryReservation(
            Application.Models.MissionRetryWork retryWork, bool hasPreparationFailed);
        Guid StartMatch(string lobbyCode, int[] participantUserIds, Guid lobbyInstanceId = default(Guid));
        PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId);
        CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId);
    }
}
