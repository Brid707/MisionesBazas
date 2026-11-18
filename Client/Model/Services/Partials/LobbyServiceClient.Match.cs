using Gameplay;

namespace Model.GameServices
{
    public partial class LobbyServiceClient
    {
        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            return Channel.GetPlayerMatch(lobbyCode, participantUserId);
        }

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            return Channel.ProcessObjectiveDraftAction(submission, participantUserId);
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return Channel.PlayCard(cardPlaySubmission, participantUserId);
        }
    }
}
