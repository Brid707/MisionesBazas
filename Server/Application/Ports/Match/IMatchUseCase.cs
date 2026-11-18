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
        System.Collections.Generic.IReadOnlyList<Application.Models.MissionTransitionWork> TakeDueMissionTransitions(
            int maximumPreparations);
        Application.Models.MissionTransitionExecutionResult ExecuteScheduledMissionTransition(
            Application.Models.MissionTransitionWork transitionWork,
            System.Threading.CancellationToken cancellationToken);
        Application.Models.MissionTransitionExecutionResult ReleaseMissionTransitionReservation(
            Application.Models.MissionTransitionWork transitionWork, bool hasPreparationFailed);
        Guid StartMatch(Application.Models.MatchStartContext startContext);
        PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId);
        CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId);
    }
}
