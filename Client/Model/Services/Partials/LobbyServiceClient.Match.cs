using Gameplay;

namespace Model.GameServices
{
    public partial class LobbyServiceClient
    {
        public MissionPreparationConfirmation IdentifyHeartNineOwner(
            HeartNineIdentificationSubmission submission, int participantUserId)
        {
            return Channel.IdentifyHeartNineOwner(submission, participantUserId);
        }

        public MissionPreparationConfirmation AssignMissionTrickDistribution(
            MissionTrickDistributionSubmission submission, int participantUserId)
        {
            return Channel.AssignMissionTrickDistribution(submission, participantUserId);
        }

        public MissionPreparationConfirmation AssignMissionRole(MissionRoleAssignmentSubmission submission,
            int participantUserId)
        {
            return Channel.AssignMissionRole(submission, participantUserId);
        }

        public MissionPreparationConfirmation RespondToBlindObjectives(BlindObjectiveResponseSubmission submission,
            int participantUserId)
        {
            return Channel.RespondToBlindObjectives(submission, participantUserId);
        }

        public RadioCommunicationConfirmation SubmitRadioCommunication(RadioCommunicationSubmission submission,
            int participantUserId)
        {
            return Channel.SubmitRadioCommunication(submission, participantUserId);
        }

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            return Channel.GetPlayerMatch(lobbyCode, participantUserId);
        }

        public MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId)
        {
            return Channel.ProcessObjectiveDraftAction(submission, participantUserId);
        }

        public MissionRetryDecision ConfirmMissionRetry(MissionRetrySubmission submission, int participantUserId)
        {
            return Channel.ConfirmMissionRetry(submission, participantUserId);
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            return Channel.PlayCard(cardPlaySubmission, participantUserId);
        }

        public DistressSignalDecision SubmitDistressSignal(
            DistressSignalSubmission submission, int participantUserId)
        {
            return Channel.SubmitDistressSignal(submission, participantUserId);
        }
    }
}
