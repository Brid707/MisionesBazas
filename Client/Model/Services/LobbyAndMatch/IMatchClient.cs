using System;
using System.Threading.Tasks;
using Gameplay;

namespace Model.Services
{
    /// <summary>Provides recipient-specific match state and retry-safe play requests on the lobby channel.</summary>
    public interface IMatchClient
    {
        event Action<long> MatchStateChanged;
        Task<MissionObjectiveDraftDecision> ProcessObjectiveDraftActionAsync(
            MissionObjectiveDraftSubmission submission, int participantUserId);
        Task<PlayerMatchSnapshot> GetPlayerMatchAsync(string lobbyCode, int participantUserId);
        Task<MissionRetryDecision> ConfirmMissionRetryAsync(MissionRetrySubmission submission, int participantUserId);
        Task<CardPlayDecision> PlayCardAsync(CardPlaySubmission cardPlaySubmission, int participantUserId);
        Task<RadioCommunicationDecision> CommunicateCardAsync(
            RadioCommunicationSubmission submission, int participantUserId);
        Task<DistressSignalDecision> SubmitDistressSignalAsync(
            DistressSignalSubmission submission, int participantUserId);
    }
}
