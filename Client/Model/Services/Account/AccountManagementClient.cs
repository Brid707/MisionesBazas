using System;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Threading.Tasks;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    [DataContract(Name = "UserRegister",
        Namespace = "http://schemas.datacontract.org/2004/07/Services.DataContracts")]
    internal sealed class UserRegisterContract
    {
        [DataMember]
        public string Username { get; set; }

        [DataMember]
        public string Email { get; set; }

        [DataMember]
        public string PasswordHash { get; set; }
    }

    [DataContract(Name = "OperationResult",
        Namespace = "http://schemas.datacontract.org/2004/07/Services.DataContracts")]
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
        private const string FallbackEndpointLogTemplate =
            "Configured account management endpoint failed to load ({ExceptionType}); falling back to default NetTcp endpoint.";
        private const string RegisterUserOperationName = "RegisterUserAsync";

        private readonly ILoggerService _logger;
        private readonly WcfFaultHandler _faultHandler;
        private ChannelFactory<IAccountManagementServiceChannel> _channelFactory;

        /// <summary>
        /// Initializes a new instance of the <see cref="AccountManagementClient"/> class.
        /// </summary>
        /// <param name="logger">The logger used to record WCF communication faults.</param>
        public AccountManagementClient(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _faultHandler = new WcfFaultHandler(_logger, RaiseConnectionError);
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

                GameChannelCloser.CloseChannel(channel, _logger);
            }
            catch (EndpointNotFoundException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RegisterUserOperationName, channel);
            }
            catch (TimeoutException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RegisterUserOperationName, channel);
            }
            catch (CommunicationException ex)
            {
                _faultHandler.ReportFaultAndClose(ex, RegisterUserOperationName, channel);
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
            catch (Exception ex)
            {
                _logger.Warning(FallbackEndpointLogTemplate, ex.GetType().Name);
                NetTcpBinding binding = new NetTcpBinding(SecurityMode.None);
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
                GameChannelCloser.CloseChannel(_channelFactory, _logger);
                _channelFactory = null;
            }
        }

        private void RaiseConnectionError(AuthenticationErrorType errorType)
        {
            ConnectionErrorOccurred?.Invoke(errorType);
        }
    }
}
