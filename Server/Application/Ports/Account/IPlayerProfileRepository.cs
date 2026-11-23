using System;
using Application.Models;

namespace Application.Ports
{
    /// <summary>
    /// Reads account profile data and replaces biography or profile image metadata.
    /// </summary>
    public interface IPlayerProfileRepository
    {
        OwnPlayerProfile GetOwnProfile(int authenticatedAccountUserId);

        string UpdateBiography(int authenticatedAccountUserId, string biography);

        PlayerProfileImageData[] GetProfileImages(int[] profileOwnerUserIds);
        Guid ReplaceProfileImage(int authenticatedAccountUserId, Guid profileImageId);
    }
}
