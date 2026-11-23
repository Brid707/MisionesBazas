using System.Threading.Tasks;
using PlayerProfiles;

namespace Model.Services
{
    /// <summary>Provides asynchronous own-profile operations without WPF dependencies.</summary>
    public interface IPlayerProfileClient
    {
        Task<PlayerProfileClientResult> GetOwnProfileAsync(string accountSessionToken);

        Task<PlayerProfileClientResult> UpdateOwnBiographyAsync(ProfileBiographyUpdate biographyUpdate);
    }
}
