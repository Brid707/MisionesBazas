using System;
using System.Threading.Tasks;

namespace Model.Services
{
    /// <summary>
    /// Shares downloaded profile images and change notifications across client views.
    /// </summary>
    public interface IProfileImageCache : IDisposable
    {
        event Action<int> ProfileImageChanged;
        void RegisterPlayer(int profileOwnerUserId);
        void UnregisterPlayer(int profileOwnerUserId);
        Task<byte[]> LoadProfileImageAsync(int profileOwnerUserId);
        Task ChangeOwnProfileImageAsync(byte[] selectedProfileImageBytes);
    }
}
