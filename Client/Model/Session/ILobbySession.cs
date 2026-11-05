
using Model.GameServices;
using Model.Services;

namespace Model.Session
{
    /// <summary>
    /// Abstraction of the active client-side lobby state and its duplex communication channel.
    /// </summary>
    public interface ILobbySession
    {
        Lobby CurrentLobby { get; }

        bool HasActiveLobby { get; }

        ILobbyClient Client { get; }

        void SetLobby(Lobby lobby);

        void ClearLobby();
    }
}
