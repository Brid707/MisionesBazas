using Application.Ports;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Host
{
    /// <summary>Groups existing lobby hosting collaborators without a four-parameter factory.</summary>
    internal sealed class LobbyHostingContext
    {
        public IUserRepository UserRepository { get; set; }
        public ILobbyChatMessageUseCase ChatMessageUseCase { get; set; }
        public IAccountAccessPolicy AccountAccessPolicy { get; set; }
        public ILoggerFactory LoggerFactory { get; set; }
    }
}
