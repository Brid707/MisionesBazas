using System;

using Model.GameServices;

namespace Model.Services
{
    /// <summary>Carries the versioned server-confirmed lobby snapshot to presentation subscribers.</summary>
    public sealed class LobbyStateChangedEventArgs : EventArgs
    {
        public LobbyStateChangedEventArgs(Lobby confirmedLobby)
        {
            ConfirmedLobby = confirmedLobby;
        }

        public Lobby ConfirmedLobby { get; }
    }
}
