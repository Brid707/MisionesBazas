using System;

namespace Application.Ports
{
    /// <summary>
    /// Persists versioned profile images without exposing physical storage paths.
    /// </summary>
    public interface IProfileImageStorage
    {
        void SaveProfileImage(Guid profileImageId, byte[] normalizedProfileImageBytes);
        byte[] ReadProfileImage(Guid profileImageId);
        void DeleteProfileImage(Guid profileImageId);
    }
}
