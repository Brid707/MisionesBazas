using Application.Models;

namespace Application.Ports
{
    /// <summary>Checks guest room access without granting friendship or account-edit permissions.</summary>
    public interface IGuestLobbyProfileAccess
    {
        bool CanViewProfile(GuestLobbyProfileAccessRequest accessRequest);
    }
}
