using System;
using System.Collections.Generic;
using System.ServiceModel;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>
    /// Centralizes structured WCF fault logging, channel cleanup, and connection error notification.
    /// </summary>
    internal sealed class WcfFaultHandler
    {
        private const string EndpointNotFoundLogTemplate = "WCF endpoint not found during {OperationName}.";
        private const string TimeoutLogTemplate = "WCF request timed out during {OperationName}.";
        private const string CommunicationLogTemplate = "WCF communication fault during {OperationName}.";

        private static readonly IReadOnlyDictionary<AuthenticationErrorType, string> FaultLogTemplates =
            new Dictionary<AuthenticationErrorType, string>
            {
                { AuthenticationErrorType.ConnectionFailed, EndpointNotFoundLogTemplate },
                { AuthenticationErrorType.Timeout, TimeoutLogTemplate },
                { AuthenticationErrorType.CommunicationError, CommunicationLogTemplate }
            };

        private readonly ILoggerService _logger;
        private readonly Action<AuthenticationErrorType> _connectionErrorNotifier;

        public WcfFaultHandler(ILoggerService logger, Action<AuthenticationErrorType> connectionErrorNotifier)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
            _connectionErrorNotifier = connectionErrorNotifier ??
                throw new ArgumentNullException(nameof(connectionErrorNotifier));
        }

        public void ReportFault(Exception exception, string operationName)
        {
            if (exception == null)
            {
                throw new ArgumentNullException(nameof(exception));
            }

            AuthenticationErrorType errorType = ResolveErrorType(exception);
            string logTemplate = FaultLogTemplates[errorType];
            _logger.Error(exception, logTemplate, operationName);
            _connectionErrorNotifier(errorType);
        }

        public void ReportFaultAndClose(Exception exception, string operationName, ICommunicationObject channel)
        {
            GameChannelCloser.CloseChannel(channel, _logger);
            ReportFault(exception, operationName);
        }

        private static AuthenticationErrorType ResolveErrorType(Exception exception)
        {
            if (exception is EndpointNotFoundException)
            {
                return AuthenticationErrorType.ConnectionFailed;
            }

            if (exception is TimeoutException)
            {
                return AuthenticationErrorType.Timeout;
            }

            return AuthenticationErrorType.CommunicationError;
        }
    }
}
