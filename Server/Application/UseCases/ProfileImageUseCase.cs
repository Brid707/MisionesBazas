using System;
using System.Linq;
using System.Threading;
using Application.Models;
using Application.Ports;
using ProfileImages;

namespace Application.UseCases
{
    /// <summary>
    /// Coordinates bounded image processing and replacement through secondary ports.
    /// </summary>
    public sealed class ProfileImageUseCase
    {
        private readonly IProfileImageProcessor _profileImageProcessor;
        private readonly IProfileImageStorage _profileImageStorage;
        private readonly IPlayerProfileRepository _playerProfileRepository;
        private readonly object[] _accountUpdateLocks = Enumerable.Range(0, 64).Select(_ => new object()).ToArray();
        private readonly SemaphoreSlim _uploadSlots = new SemaphoreSlim(2, 2);

        public ProfileImageUseCase(IProfileImageProcessor profileImageProcessor,
            IProfileImageStorage profileImageStorage, IPlayerProfileRepository playerProfileRepository)
        {
            _profileImageProcessor = profileImageProcessor;
            _profileImageStorage = profileImageStorage;
            _playerProfileRepository = playerProfileRepository;
        }

        public PlayerProfileImageData ChangeOwnProfileImage(int authenticatedAccountUserId, byte[] imageBytes)
        {
            if (authenticatedAccountUserId <= 0)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.AuthenticationRequired);
            }
            if (!_uploadSlots.Wait(0))
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageServiceBusy);
            }
            PlayerProfileImageData updatedProfileImage;
            try
            {
                byte[] normalizedProfileImageBytes = _profileImageProcessor.NormalizeProfileImage(imageBytes);
                lock (_accountUpdateLocks[authenticatedAccountUserId % _accountUpdateLocks.Length])
                {
                    updatedProfileImage = PersistProfileImage(authenticatedAccountUserId, normalizedProfileImageBytes);
                }
            }
            finally
            {
                _uploadSlots.Release();
            }
            return updatedProfileImage;
        }

        private PlayerProfileImageData PersistProfileImage(int accountUserId, byte[] normalizedImageBytes)
        {
            Guid profileImageId = Guid.NewGuid();
            _profileImageStorage.SaveProfileImage(profileImageId, normalizedImageBytes);
            Guid previousProfileImageId;
            try
            {
                previousProfileImageId = _playerProfileRepository.ReplaceProfileImage(accountUserId, profileImageId);
            }
            catch (InvalidOperationException)
            {
                _profileImageStorage.DeleteProfileImage(profileImageId);
                throw;
            }
            _profileImageStorage.DeleteProfileImage(previousProfileImageId);
            return new PlayerProfileImageData { ProfileOwnerUserId = accountUserId, ProfileImageId = profileImageId };
        }

        public PlayerProfileImageData[] GetPlayerProfileImages(int[] profileOwnerUserIds)
        {
            if (profileOwnerUserIds == null || profileOwnerUserIds.Length > ProfileImageLimits.MaximumRequestedPlayers)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageRequest);
            }
            int[] distinctOwnerIds = profileOwnerUserIds.Where(ownerId => ownerId > 0).Distinct().ToArray();
            return _playerProfileRepository.GetProfileImages(distinctOwnerIds);
        }

        public byte[] GetProfileImage(Guid profileImageId)
        {
            if (profileImageId == Guid.Empty)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageNotFound);
            }
            return _profileImageStorage.ReadProfileImage(profileImageId);
        }
    }
}
