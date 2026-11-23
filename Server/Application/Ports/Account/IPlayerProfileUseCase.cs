using Application.Models;

namespace Application.Ports
{
    /// <summary>Reads and edits the profile belonging to an already authorized account.</summary>
    public interface IPlayerProfileUseCase
    {
        OwnPlayerProfile GetOwnProfile(int authenticatedAccountUserId);

        string UpdateOwnBiography(int authenticatedAccountUserId, string biography);
    }
}
