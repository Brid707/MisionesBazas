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
        /// <summary>
        /// Validates and records a player's radio communication token usage.
        /// </summary>
        /// <param name="submission">The radio communication submission.</param>
        /// <param name="participantUserId">The requesting participant user identifier.</param>
        /// <returns>A decision describing acceptance or rejection reason.</returns>
        RadioCommunicationDecision CommunicateCard(RadioCommunicationSubmission submission, int participantUserId);

        /// <summary>
        /// Submits a distress signal pass decision, executing the card rotation when all participants agree.
        /// </summary>
        /// <param name="submission">The distress signal submission.</param>
        /// <param name="participantUserId">The requesting participant user identifier.</param>
        /// <returns>A decision describing acceptance and execution status.</returns>
        DistressSignalDecision SubmitDistressSignal(DistressSignalSubmission submission, int participantUserId);
    }
}
