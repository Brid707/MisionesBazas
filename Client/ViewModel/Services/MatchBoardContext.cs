using System;
using Model.Services;

namespace ViewModel.Services
{
    /// <summary>
    /// Groups match identity and transport client dependencies for <see cref="ViewModels.MatchBoardViewModel"/>.
    /// </summary>
    public sealed class MatchBoardContext
    {
        private const string EmptyLobbyCodeMessage = "Lobby code must not be null or whitespace.";

        public MatchBoardContext(string lobbyCode, int participantUserId, IMatchClient matchClient)
        {
            if (string.IsNullOrWhiteSpace(lobbyCode))
            {
                throw new ArgumentException(EmptyLobbyCodeMessage, nameof(lobbyCode));
            }

            LobbyCode = lobbyCode;
            ParticipantUserId = participantUserId;
            MatchClient = matchClient ?? throw new ArgumentNullException(nameof(matchClient));
        }

        public string LobbyCode { get; }

        public int ParticipantUserId { get; }

        public IMatchClient MatchClient { get; }
    }
}
