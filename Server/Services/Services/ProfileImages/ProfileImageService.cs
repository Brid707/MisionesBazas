using System;
using System.IO;
using System.Linq;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Application.UseCases;
using ProfileImages;
using Services.Contracts;
using Services.DataContracts;
using Services.Security;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Services.Services
{
    /// <summary>
    /// Adapts authenticated profile image use cases to isolated typed WCF operations.
    /// </summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Multiple,
        IncludeExceptionDetailInFaults = false)]
    public sealed class ProfileImageService : IProfileImageService
    {
        private const string ProfileImageUpdatedTemplate =
            "Profile image updated for account {AccountId}.";
        private const string ProfileImageOperationRejectedTemplate =
            "Profile image operation rejected with failure code {FailureCode}.";
        private const string ProfileImageValidationUnderlyingFailureTemplate =
            "Profile image validation preserved an underlying infrastructure failure.";
        private const string ProfileImageStorageUnavailableTemplate =
            "Profile image storage is unavailable.";
        private const string ProfileImageStoragePermissionDeniedTemplate =
            "Profile image storage permission was denied.";
        private const string ProfileImageMetadataUnavailableTemplate =
            "Profile image metadata is unavailable.";
        private const string ProfileImageOperationFaultReason =
            "The profile image operation could not be completed.";

        private readonly ProfileImageUseCase _profileImageUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;
        private readonly ILoggerService _logger;
        private readonly ProfileImageSubscriptions _subscriptions;

        public ProfileImageService(ProfileImageUseCase profileImageUseCase,
            IAccountAccessPolicy accountAccessPolicy, ILoggerService logger)
        {
            _profileImageUseCase = profileImageUseCase ?? throw new ArgumentNullException(nameof(profileImageUseCase));
            _accountAccessPolicy = accountAccessPolicy ?? throw new ArgumentNullException(nameof(accountAccessPolicy));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _subscriptions = new ProfileImageSubscriptions(logger);
        }

        public PlayerProfileImageReference ChangeOwnProfileImage(ProfileImageUpload profileImageUpload)
        {
            return ExecuteImageOperation(() => ChangeAuthenticatedProfileImage(profileImageUpload));
        }

        private PlayerProfileImageReference ChangeAuthenticatedProfileImage(ProfileImageUpload upload)
        {
            int accountUserId = _accountAccessPolicy.ResolveAllowedAccountUserId(
                AccountSessionHeader.ReadCurrentAccountSessionToken());
            PlayerProfileImageData changedImage = _profileImageUseCase.ChangeOwnProfileImage(
                accountUserId, upload?.SelectedProfileImageBytes);
            _logger.Information(ProfileImageUpdatedTemplate, accountUserId);
            _subscriptions.Publish(accountUserId);
            return MapProfileImage(changedImage);
        }

        public PlayerProfileImageReference[] GetPlayerProfileImages(int[] profileOwnerUserIds)
        {
            return ExecuteImageOperation(() => _profileImageUseCase.GetPlayerProfileImages(profileOwnerUserIds)
                .Select(MapProfileImage).ToArray());
        }

        public ProfileImageContent GetProfileImage(Guid profileImageId)
        {
            return ExecuteImageOperation(() => new ProfileImageContent
            {
                ProfileImageId = profileImageId,
                NormalizedProfileImageBytes = _profileImageUseCase.GetProfileImage(profileImageId)
            });
        }

        public void SubscribeProfileImageChanges(int[] profileOwnerUserIds)
        {
            ExecuteImageOperation(() => IsImageSubscriptionRegistered(profileOwnerUserIds));
        }

        private bool IsImageSubscriptionRegistered(int[] profileOwnerUserIds)
        {
            _subscriptions.Subscribe(profileOwnerUserIds);
            return true;
        }

        private T ExecuteImageOperation<T>(Func<T> imageOperation)
        {
            T result;
            try
            {
                result = imageOperation();
            }
            catch (ProfileImageException ex)
            {
                _logger.Warning(ProfileImageOperationRejectedTemplate, ex.FailureCode);
                if (ex.InnerException != null)
                {
                    _logger.Error(ex, ProfileImageValidationUnderlyingFailureTemplate);
                }
                throw CreateImageFault(ex.FailureCode);
            }
            catch (IOException ex)
            {
                _logger.Error(ex, ProfileImageStorageUnavailableTemplate);
                throw CreateImageFault(ProfileImageFailureCodes.ImageStorageUnavailable);
            }
            catch (UnauthorizedAccessException ex)
            {
                _logger.Error(ex, ProfileImageStoragePermissionDeniedTemplate);
                throw CreateImageFault(ProfileImageFailureCodes.ImageStorageUnavailable);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, ProfileImageMetadataUnavailableTemplate);
                throw CreateImageFault(ProfileImageFailureCodes.ImageStorageUnavailable);
            }
            return result;
        }

        private static PlayerProfileImageReference MapProfileImage(PlayerProfileImageData image)
        {
            return new PlayerProfileImageReference
            {
                ProfileOwnerUserId = image.ProfileOwnerUserId,
                ProfileImageId = image.ProfileImageId
            };
        }

        private static FaultException<ProfileImageFault> CreateImageFault(string failureCode)
        {
            return new FaultException<ProfileImageFault>(new ProfileImageFault { FailureCode = failureCode },
                new FaultReason(ProfileImageOperationFaultReason));
        }
    }
}
