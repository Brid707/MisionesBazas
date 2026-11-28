using System.Threading.Tasks;
using Model.PlayerProfileService;

namespace Model.Services
{
    /// <summary>Provides asynchronous own-profile operations without WPF dependencies.</summary>
    public interface IPlayerProfileClient
    {
        Task<PlayerProfileClientResult> GetPublicProfileAsync(PublicPlayerProfileLookup profileLookup);

        Task<PlayerProfileClientResult> GetOwnProfileAsync(string accountSessionToken);

        Task<PlayerProfileClientResult> UpdateOwnBiographyAsync(ProfileBiographyUpdate biographyUpdate);
    }
}
