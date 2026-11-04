using System;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Threading.Tasks;

namespace Model.Services
{
    [DataContract(Name = "UserRegister", Namespace = "http://schemas.datacontract.org/2004/07/Services.DTO")]
    internal sealed class UserRegisterContract
    {
        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string PasswordHash { get; set; }
    }

    [DataContract(Name = "OperationResult", Namespace = "http://schemas.datacontract.org/2004/07/Services.DTO")]
    internal class OperationResultContract
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string Message { get; set; }

        [DataMember]
        public int ErrorCode { get; set; }
    }

    [ServiceContract(Name = "IAccountManagementService", Namespace = "http://tempuri.org/")]
    internal interface IAccountManagementServiceChannel : IClientChannel
    {
        [OperationContract(Action = "http://tempuri.org/IAccountManagementService/RegisterUser", ReplyAction = "http://tempuri.org/IAccountManagementService/RegisterUserResponse")]
        OperationResultContract RegisterUser(UserRegisterContract user);

        [OperationContract(Action = "http://tempuri.org/IAccountManagementService/RegisterUser", ReplyAction = "http://tempuri.org/IAccountManagementService/RegisterUserResponse")]
        Task<OperationResultContract> RegisterUserAsync(UserRegisterContract user);
    }

    /// <summary>
    /// Manages client-side WCF communication for user account registration operations.
    /// Strictly complies with rules 16.3.1 (no using on WCF clients) and 16.3.2 (GameChannelCloser).
    /// </summary>
    public sealed class AccountManagementClient : IAccountManagementClient
    {
        private const string EndpointConfigurationName = "NetTcpBinding_IAccountManagementService";
        private const string DefaultEndpointAddress = "net.tcp://localhost:8090/AccountManagementService";

        private ChannelFactory<IAccountManagementServiceChannel> _channelFactory;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementClient"/> class.
        /// </summary>
        public AccountManagementClient()
        {
            InitializeChannelFactory();
        }

        /// <inheritdoc />
        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        /// <inheritdoc />
        public async Task<AccountRegistrationResult> RegisterUserAsync(string username, string email, string passwordHash)
        {
            AccountRegistrationResult registrationResult = null;
            IAccountManagementServiceChannel channel = null;

            UserRegisterContract payload = new UserRegisterContract
            {
                Username = username,
                Email = email,
                PasswordHash = passwordHash
            };

            try
            {
                EnsureFactoryIsOpen();
                channel = _channelFactory.CreateChannel();

                OperationResultContract response = await channel.RegisterUserAsync(payload);

                if (response != null)
                {
                    registrationResult = new AccountRegistrationResult
                    {
                        IsSuccess = response.IsSuccess,
                        ErrorCode = response.ErrorCode,
                        Message = response.Message
                    };
                }

                GameChannelCloser.CloseChannel(channel);
            }
            catch (EndpointNotFoundException)
            {
                GameChannelCloser.CloseChannel(channel);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                GameChannelCloser.CloseChannel(channel);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                GameChannelCloser.CloseChannel(channel);
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }

            return registrationResult;
        }

        /// <inheritdoc />
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void InitializeChannelFactory()
        {
            try
            {
                _channelFactory = new ChannelFactory<IAccountManagementServiceChannel>(EndpointConfigurationName);
            }
            catch (Exception)
            {
                NetTcpBinding binding = new NetTcpBinding(SecurityMode.Transport);
                EndpointAddress endpointAddress = new EndpointAddress(DefaultEndpointAddress);
                _channelFactory = new ChannelFactory<IAccountManagementServiceChannel>(binding, endpointAddress);
            }
        }

        private void EnsureFactoryIsOpen()
        {
            if (_channelFactory == null ||
                _channelFactory.State == CommunicationState.Faulted ||
                _channelFactory.State == CommunicationState.Closed)
            {
                InitializeChannelFactory();
            }
        }

        private void Dispose(bool disposing)
        {
            if (disposing && _channelFactory != null)
            {
                GameChannelCloser.CloseChannel(_channelFactory);
                _channelFactory = null;
            }
        }
    }
}
