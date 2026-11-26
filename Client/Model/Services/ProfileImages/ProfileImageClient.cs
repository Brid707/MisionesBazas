using System;
using System.Net.Security;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.ProfileImageService;
using Model.Security;
using ProfileImages;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>
    /// Adapts the profile image contract to an authenticated WCF channel.
    /// </summary>
    [CallbackBehavior(UseSynchronizationContext = false, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class ProfileImageClient : IProfileImageClient, IProfileImageServiceCallback
    {
        private const string ConnectionFailedLogTemplate = "Profile image connection failed: {ExceptionType}.";
        private const string ConnectionTimedOutLogTemplate = "Profile image connection timed out: {ExceptionType}.";

        private readonly string _endpointAddress;
        private readonly ILoggerService _logger;
        private DuplexChannelFactory<IProfileImageService> _channelFactory;
        private IProfileImageService _profileImageChannel;

        public ProfileImageClient(string endpointAddress, ILoggerService logger)
        {
            _endpointAddress = endpointAddress;
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public event Action<int> ProfileImageChanged;

        public Task<PlayerProfileImageReference[]> GetPlayerProfileImagesAsync(int[] profileOwnerUserIds)
        {
            return ExecuteAsync(channel => channel.GetPlayerProfileImages(profileOwnerUserIds));
        }

        public Task<ProfileImageContent> GetProfileImageAsync(Guid profileImageId)
        {
            return ExecuteAsync(channel => channel.GetProfileImage(profileImageId));
        }

        public Task<PlayerProfileImageReference> ChangeOwnProfileImageAsync(byte[] selectedProfileImageBytes)
        {
            return ExecuteAsync(channel => channel.ChangeOwnProfileImage(new ProfileImageUpload
            {
                SelectedProfileImageBytes = selectedProfileImageBytes
            }));
        }

        public Task SubscribeProfileImageChangesAsync(int[] profileOwnerUserIds)
        {
            return ExecuteAsync(channel => IsImageSubscriptionRegistered(channel, profileOwnerUserIds));
        }

        private static bool IsImageSubscriptionRegistered(IProfileImageService channel, int[] profileOwnerUserIds)
        {
            channel.SubscribeProfileImageChanges(profileOwnerUserIds);
            return true;
        }

        public void OnPlayerProfileImageChanged(int profileOwnerUserId)
        {
            ProfileImageChanged?.Invoke(profileOwnerUserId);
        }

        private Task<T> ExecuteAsync<T>(Func<IProfileImageService, T> operation)
        {
            return Task.Run(() => ExecuteOperation(operation));
        }

        private T ExecuteOperation<T>(Func<IProfileImageService, T> operation)
        {
            T result;
            try
            {
                EnsureChannel();
                result = operation(_profileImageChannel);
            }
            catch (FaultException<ProfileImageFault> ex)
            {
                throw new ProfileImageOperationException(ex.Detail.FailureCode, ex);
            }
            catch (CommunicationException ex)
            {
                _logger.Warning(ConnectionFailedLogTemplate, ex.GetType().Name);
                Dispose();
                throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageConnectionUnavailable, ex);
            }
            catch (TimeoutException ex)
            {
                _logger.Warning(ConnectionTimedOutLogTemplate, ex.GetType().Name);
                Dispose();
                throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageConnectionUnavailable, ex);
            }
            return result;
        }

        private void EnsureChannel()
        {
            if (_profileImageChannel == null || ((ICommunicationObject)_profileImageChannel).State !=
                CommunicationState.Opened)
            {
                Dispose();
                var binding = new NetTcpBinding(SecurityMode.None)
                {
                    MaxReceivedMessageSize = ProfileImageLimits.MaximumTransportMessageBytes,
                    MaxBufferSize = ProfileImageLimits.MaximumTransportMessageBytes,
                    CloseTimeout = TimeSpan.FromSeconds(2),
                    OpenTimeout = TimeSpan.FromSeconds(5),
                    SendTimeout = TimeSpan.FromSeconds(10)
                };
                binding.ReaderQuotas.MaxArrayLength = ProfileImageLimits.MaximumUploadBytes;
                _channelFactory = new DuplexChannelFactory<IProfileImageService>(new InstanceContext(this),
                    binding, new EndpointAddress(_endpointAddress));
                _channelFactory.Endpoint.EndpointBehaviors.Add(new AccountSessionEndpointBehavior());
                _profileImageChannel = _channelFactory.CreateChannel();
                ((ICommunicationObject)_profileImageChannel).Open();
            }
        }

        public void Dispose()
        {
            GameChannelCloser.CloseChannel(_profileImageChannel as ICommunicationObject, _logger);
            GameChannelCloser.CloseChannel(_channelFactory, _logger);
            _profileImageChannel = null;
            _channelFactory = null;
        }
    }
}
