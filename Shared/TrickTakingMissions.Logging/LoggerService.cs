using System;
using System.Text;
using System.Text.RegularExpressions;
using log4net;
using log4net.Core;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace TrickTakingMissions.Logging
{
    /// <summary>log4net adapter for <see cref="ILoggerService"/> supporting static named placeholders.</summary>
    public sealed class LoggerService : ILoggerService
    {
        private const string NamedPlaceholderPattern = @"\{[a-zA-Z0-9_]+\}";
        private const string NullArgumentText = "null";

        private static readonly Type DeclaringType = typeof(LoggerService);
        private static readonly Regex NamedPlaceholderRegex =
            new Regex(NamedPlaceholderPattern, RegexOptions.Compiled);

        private readonly ILog _logger;

        public LoggerService(Type callerType)
        {
            if (callerType == null)
            {
                throw new ArgumentNullException(nameof(callerType));
            }

            _logger = LogManager.GetLogger(callerType);
        }

        public void Trace(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.Logger.IsEnabledFor(Level.Trace))
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Logger.Log(DeclaringType, Level.Trace, formattedMessage, null);
            }
        }

        public void Debug(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsDebugEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Debug(formattedMessage);
            }
        }

        public void Information(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsInfoEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Info(formattedMessage);
            }
        }

        public void Warning(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsWarnEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Warn(formattedMessage);
            }
        }

        public void Error(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsErrorEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Error(formattedMessage);
            }
        }

        public void Error(Exception exception, string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsErrorEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Error(formattedMessage, exception);
            }
        }

        public void Fatal(string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsFatalEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Fatal(formattedMessage);
            }
        }

        public void Fatal(Exception exception, string messageTemplate, params object[] messageArguments)
        {
            if (_logger.IsFatalEnabled)
            {
                string formattedMessage = FormatMessageTemplate(messageTemplate, messageArguments);
                _logger.Fatal(formattedMessage, exception);
            }
        }

        private static string FormatMessageTemplate(string messageTemplate, object[] messageArguments)
        {
            string formattedMessage = messageTemplate ?? string.Empty;

            if (!string.IsNullOrEmpty(formattedMessage) && messageArguments != null && messageArguments.Length > 0)
            {
                StringBuilder messageBuilder = new StringBuilder(formattedMessage.Length);
                MatchCollection placeholderMatches = NamedPlaceholderRegex.Matches(formattedMessage);
                int currentTextPosition = 0;
                int argumentIndex = 0;

                foreach (Match placeholderMatch in placeholderMatches)
                {
                    if (argumentIndex < messageArguments.Length)
                    {
                        messageBuilder.Append(formattedMessage, currentTextPosition,
                            placeholderMatch.Index - currentTextPosition);
                        string argumentText = messageArguments[argumentIndex]?.ToString() ?? NullArgumentText;

                        messageBuilder.Append(argumentText);
                        currentTextPosition = placeholderMatch.Index + placeholderMatch.Length;
                        argumentIndex++;
                    }
                }

                messageBuilder.Append(formattedMessage, currentTextPosition, 
                    formattedMessage.Length - currentTextPosition);
                formattedMessage = messageBuilder.ToString();
            }

            return formattedMessage;
        }
    }
}
