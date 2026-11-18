using Application.Models;

namespace Application.Ports
{
    /// <summary>Reads registered connection generations and verifies automatic client responsiveness.</summary>
    public interface IMatchParticipantPresence
    {
        MatchParticipantPresence ReadPresence(MatchPresenceQuery query);
        bool ConfirmPresence(MatchPresenceQuery query);
    }
}
