using System;
using System.Threading.Tasks;
using Gameplay;

namespace Model.Services
{
    /// <summary>Provides recipient-specific match state and retry-safe play requests on the lobby channel.</summary>
    public interface IMatchClient
    {
        Task<MissionPreparationConfirmation> IdentifyHeartNineOwnerAsync(
            HeartNineIdentificationSubmission submission, int participantUserId);
        Task<MissionPreparationConfirmation> AssignMissionTrickDistributionAsync(
            MissionTrickDistributionSubmission submission, int participantUserId);
        Task<MissionPreparationConfirmation> AssignMissionRoleAsync(
            MissionRoleAssignmentSubmission submission, int participantUserId);
        Task<MissionPreparationConfirmation> RespondToBlindObjectivesAsync(
            BlindObjectiveResponseSubmission submission, int participantUserId);
        event Action<long> MatchStateChanged;
        Task<RadioCommunicationConfirmation> SubmitRadioCommunicationAsync(
            RadioCommunicationSubmission submission, int participantUserId);
        Task<MissionObjectiveDraftDecision> ProcessObjectiveDraftActionAsync(
            MissionObjectiveDraftSubmission submission, int participantUserId);
        Task<PlayerMatchSnapshot> GetPlayerMatchAsync(string lobbyCode, int participantUserId);
        Task<MissionRetryDecision> ConfirmMissionRetryAsync(MissionRetrySubmission submission, int participantUserId);
        Task<CardPlayDecision> PlayCardAsync(CardPlaySubmission cardPlaySubmission, int participantUserId);
    }
}
