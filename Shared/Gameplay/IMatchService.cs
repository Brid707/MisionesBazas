using System.ServiceModel;

namespace Gameplay
{
    /// <summary>Exposes private match queries and identified play requests over the participant channel.</summary>
    [ServiceContract]
    public interface IMatchService
    {
        [OperationContract(Action = "urn:misiones-bazas:match:ProcessObjectiveDraftAction", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        MissionObjectiveDraftDecision ProcessObjectiveDraftAction(
            MissionObjectiveDraftSubmission submission, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:GetPlayerMatch", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:ConfirmMissionRetry", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        MissionRetryDecision ConfirmMissionRetry(MissionRetrySubmission submission, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:PlayCard", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId);
    }
}
