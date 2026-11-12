using System;


namespace Application.Ports
{
    /// <summary>Records technical moderation failures without exposing chat text or session credentials.</summary>
    public interface IChatModerationLogger
    {
        void RecordPersistenceFailure(string accountOperationName, Exception persistenceFailure);
    }
}
