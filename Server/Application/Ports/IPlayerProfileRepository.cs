using System;
using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Reads and replaces the persisted relationship between accounts and profile images.
    /// </summary>
    public interface IPlayerProfileRepository
    {
        PlayerProfileImageData[] GetProfileImages(int[] profileOwnerUserIds);
        Guid ReplaceProfileImage(int authenticatedAccountUserId, Guid profileImageId);
    }
}
