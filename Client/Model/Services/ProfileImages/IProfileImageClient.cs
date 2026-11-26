using System;
using System.Threading.Tasks;
using Model.ProfileImageService;

namespace Model.Services
{
    /// <summary>
    /// Defines asynchronous access to the dedicated profile image transport.
    /// </summary>
    public interface IProfileImageClient : IDisposable
    {
        event Action<int> ProfileImageChanged;
        Task<PlayerProfileImageReference[]> GetPlayerProfileImagesAsync(int[] profileOwnerUserIds);
        Task<ProfileImageContent> GetProfileImageAsync(Guid profileImageId);
        Task<PlayerProfileImageReference> ChangeOwnProfileImageAsync(byte[] selectedProfileImageBytes);
        Task SubscribeProfileImageChangesAsync(int[] profileOwnerUserIds);
    }
}
