using System;
using System.IO;
using Application.Models;
using Application.Ports;
using ProfileImages;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Infrastructure.ProfileImages
{
    /// <summary>
    /// Stores generated profile image names and logs cleanup failures without losing a saved profile.
    /// </summary>
    public sealed class FileProfileImageStorage : IProfileImageStorage
    {
        private readonly string _profileImagesDirectoryPath;
        private readonly ILoggerService _logger;

        public FileProfileImageStorage(string profileImagesDirectoryPath, ILoggerService logger)
        {
            _profileImagesDirectoryPath = Path.GetFullPath(profileImagesDirectoryPath);
            _logger = logger;
        }

        public void SaveProfileImage(Guid profileImageId, byte[] normalizedProfileImageBytes)
        {
            Directory.CreateDirectory(_profileImagesDirectoryPath);
            string imagePath = GetImagePath(profileImageId);
            string pendingImagePath = imagePath + ".pending";
            try
            {
                using (var imageStream = new FileStream(pendingImagePath, FileMode.CreateNew,
                    FileAccess.Write, FileShare.None))
                {
                    imageStream.Write(normalizedProfileImageBytes, 0, normalizedProfileImageBytes.Length);
                    imageStream.Flush(true);
                }
                File.Move(pendingImagePath, imagePath);
            }
            finally
            {
                DeleteFileIfPresent(pendingImagePath);
            }
        }

        public byte[] ReadProfileImage(Guid profileImageId)
        {
            string imagePath = GetImagePath(profileImageId);
            var imageFile = new FileInfo(imagePath);
            if (!imageFile.Exists)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageNotFound);
            }
            if (imageFile.Length > ProfileImageLimits.MaximumStoredImageBytes)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidStoredImage);
            }
            byte[] imageBytes;
            using (var imageStream = new FileStream(imagePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            using (var imageReader = new BinaryReader(imageStream))
            {
                imageBytes = imageReader.ReadBytes(ProfileImageLimits.MaximumStoredImageBytes + 1);
                if (imageBytes.Length > ProfileImageLimits.MaximumStoredImageBytes)
                {
                    throw new ProfileImageException(ProfileImageFailureCodes.InvalidStoredImage);
                }
            }
            return imageBytes;
        }

        public void DeleteProfileImage(Guid profileImageId)
        {
            if (profileImageId != Guid.Empty)
            {
                DeleteFileIfPresent(GetImagePath(profileImageId));
            }
        }

        private void DeleteFileIfPresent(string imagePath)
        {
            try
            {
                File.Delete(imagePath);
            }
            catch (IOException ex)
            {
                _logger.Error(ex, "Profile image cleanup failed for {ImageFile}.", Path.GetFileName(imagePath));
            }
            catch (UnauthorizedAccessException ex)
            {
                _logger.Error(ex, "Profile image cleanup was denied for {ImageFile}.",
                    Path.GetFileName(imagePath));
            }
        }

        private string GetImagePath(Guid profileImageId)
        {
            return Path.Combine(_profileImagesDirectoryPath, "Avatar_Profile_" + profileImageId.ToString("N") + ".png");
        }
    }
}
