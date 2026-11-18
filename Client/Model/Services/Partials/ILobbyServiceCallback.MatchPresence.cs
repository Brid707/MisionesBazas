using System;
using System.ServiceModel;

namespace Model.GameServices
{
    /// <summary>Adds an automatic presence response without altering generated callback members.</summary>
    public partial interface ILobbyServiceCallback
    {
        [OperationContract(Action = "urn:misiones-bazas:match:Presence", ReplyAction = "*")]
        bool IsMatchParticipantConnected(Guid matchId, int missionAttemptId);
    }
}
