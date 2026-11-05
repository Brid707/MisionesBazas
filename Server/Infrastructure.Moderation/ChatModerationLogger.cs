using System.Collections.Generic;
using System.Diagnostics;
using System;

using Application.Ports;

namespace Infrastructure.Moderation
{
    /// <summary>Writes static named templates and separate diagnostic fields through a .NET trace source.</summary>
    public sealed class ChatModerationLogger : IChatModerationLogger
    {
        private const int PersistenceFailureEventId = 1;
        private const string PersistenceFailureTemplate = "Chat persistence failed for {AccountOperationName}.";
        private readonly TraceSource _chatModerationTraceSource =
            new TraceSource("ChatModeration", SourceLevels.Warning);

        public void RecordPersistenceFailure(string accountOperationName, Exception persistenceFailure)
        {
            _chatModerationTraceSource.TraceData(TraceEventType.Error, PersistenceFailureEventId,
                PersistenceFailureTemplate,
                new KeyValuePair<string, string>("AccountOperationName", accountOperationName),
                new KeyValuePair<string, string>("FailureType", persistenceFailure.GetType().FullName));
            _chatModerationTraceSource.Flush();
        }
    }
}
