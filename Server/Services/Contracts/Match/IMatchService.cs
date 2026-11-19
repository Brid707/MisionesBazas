using System.ServiceModel;

using Gameplay;

namespace Services.Contracts
{
    /// <summary>Exposes private match queries and identified play requests over the participant channel.</summary>
    [ServiceContract]
    public interface IMatchService
    {
        [OperationContract(Action = "urn:misiones-bazas:match:IdentifyHeartNineOwner", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(MissionPreparationFault))]
        MissionPreparationConfirmation IdentifyHeartNineOwner(
            HeartNineIdentificationSubmission submission, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:AssignMissionTrickDistribution", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(MissionPreparationFault))]
        MissionPreparationConfirmation AssignMissionTrickDistribution(
            MissionTrickDistributionSubmission submission, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:AssignMissionRole", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(MissionPreparationFault))]
        MissionPreparationConfirmation AssignMissionRole(MissionRoleAssignmentSubmission submission, int
            participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:RespondToBlindObjectives", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(MissionPreparationFault))]
        MissionPreparationConfirmation RespondToBlindObjectives(BlindObjectiveResponseSubmission submission, int
            participantUserId);

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

        [OperationContract(Action = "urn:misiones-bazas:match:SubmitRadioCommunication", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(RadioCommunicationFault))]
        RadioCommunicationConfirmation SubmitRadioCommunication(RadioCommunicationSubmission submission,
            int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:PlayCard", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId);

        [OperationContract(Action = "urn:misiones-bazas:match:SubmitDistressSignal", ReplyAction = "*")]
        [FaultContract(typeof(MatchAccessFault))]
        [FaultContract(typeof(DistressSignalFault))]
        DistressSignalConfirmation SubmitDistressSignal(DistressSignalSubmission submission, int participantUserId);
    }
}
