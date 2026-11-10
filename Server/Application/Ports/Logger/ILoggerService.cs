using System;

namespace Application.Ports.Logger
{
    public interface ILoggerService
    {
        void Trace(string messageTemplate, params object[] messageArguments);

        void Debug(string messageTemplate, params object[] messageArguments);

        void Information(string messageTemplate, params object[] messageArguments);

        void Warning(string messageTemplate, params object[] messageArguments);

        void Error(string messageTemplate, params object[] messageArguments);

        void Error(Exception exception, string messageTemplate, params object[] messageArguments);

        void Fatal(string messageTemplate, params object[] messageArguments);

        void Fatal(Exception exception, string messageTemplate, params object[] messageArguments);
    }
}
