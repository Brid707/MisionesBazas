using System.Globalization;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a pending match invitation inside the social sidebar.
    /// </summary>
    public sealed class GameInvitationItemViewModel : ViewModelBase
    {
        public GameInvitationItemViewModel(int senderUserId, string senderUsername, string lobbyCode,
            byte targetMissionCount, int currentPlayerCount, byte playerLimit)
        {
            SenderUserId = senderUserId;
            SenderUsername = senderUsername ?? string.Empty;
            LobbyCode = lobbyCode ?? string.Empty;
            TargetMissionCount = targetMissionCount;
            CurrentPlayerCount = currentPlayerCount;
            PlayerLimit = playerLimit;
            PlayersCountDisplay = string.Format(CultureInfo.InvariantCulture, "{0}/{1}",
                currentPlayerCount, playerLimit);
        }

        public int SenderUserId { get; }

        public string SenderUsername { get; }

        public string LobbyCode { get; }

        public byte TargetMissionCount { get; }

        public int CurrentPlayerCount { get; }

        public byte PlayerLimit { get; }

        public string PlayersCountDisplay { get; }
    }
}
