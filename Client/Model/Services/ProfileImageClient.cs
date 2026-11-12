using System;
using System.Diagnostics;
using System.Net.Security;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.Security;
using ProfileImages;
using Services.Contracts;
using Services.DataContracts;

namespace Model.Services
{
    /// <summary>
    /// Adapts the profile image contract to an authenticated encrypted WCF channel.
    /// </summary>
    [CallbackBehavior(UseSynchronizationContext = false, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class ProfileImageClient : IProfileImageClient, IProfileImageCallback
    {
        private readonly string _endpointAddress;
        private DuplexChannelFactory<IProfileImageService> _channelFactory;
        private IProfileImageService _profileImageChannel;

        public ProfileImageClient(string endpointAddress)
        {
            _endpointAddress = endpointAddress;
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
                Trace.TraceWarning("Profile image connection failed: {0}", ex.GetType().Name);
                Dispose();
                throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageConnectionUnavailable, ex);
            }
            catch (TimeoutException ex)
            {
                Trace.TraceWarning("Profile image connection timed out: {0}", ex.GetType().Name);
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
                var binding = new NetTcpBinding(SecurityMode.Transport)
                {
                    MaxReceivedMessageSize = ProfileImageLimits.MaximumTransportMessageBytes,
                    MaxBufferSize = ProfileImageLimits.MaximumTransportMessageBytes,
                    CloseTimeout = TimeSpan.FromSeconds(2),
                    OpenTimeout = TimeSpan.FromSeconds(5),
                    SendTimeout = TimeSpan.FromSeconds(10)
                };
                binding.ReaderQuotas.MaxArrayLength = ProfileImageLimits.MaximumUploadBytes;
                binding.Security.Transport.ProtectionLevel = ProtectionLevel.EncryptAndSign;
                _channelFactory = new DuplexChannelFactory<IProfileImageService>(new InstanceContext(this),
                    binding, new EndpointAddress(_endpointAddress));
                _channelFactory.Endpoint.EndpointBehaviors.Add(new AccountSessionEndpointBehavior());
                _profileImageChannel = _channelFactory.CreateChannel();
                ((ICommunicationObject)_profileImageChannel).Open();
            }
        }

        public void Dispose()
        {
            GameChannelCloser.CloseChannel(_profileImageChannel as ICommunicationObject);
            GameChannelCloser.CloseChannel(_channelFactory);
            _profileImageChannel = null;
            _channelFactory = null;
        }
    }
}
