using System;
using System.Collections.Generic;
using Application.Models;
using Application.Ports;

namespace Host.Gameplay
{
    /// <summary>Bounds process-local matches without evicting live hands or replay decisions.</summary>
    internal sealed class InMemoryMatchStateStore : IMatchStateStore
    {
        private const int MaximumRetainedMatches = 128;
        private readonly Dictionary<string, MatchState> _matchesByLobbyCode =
            new Dictionary<string, MatchState>(StringComparer.OrdinalIgnoreCase);

        public MatchState GetOrCreateMatch(string lobbyCode, Func<MatchState> createMatch)
        {
            MatchState matchState;
            lock (_matchesByLobbyCode)
            {
                if (!_matchesByLobbyCode.TryGetValue(lobbyCode, out matchState))
                {
                    if (_matchesByLobbyCode.Count >= MaximumRetainedMatches)
                    {
                        throw new InvalidOperationException("MatchCapacityReached");
                    }
                    matchState = createMatch();
                    _matchesByLobbyCode.Add(lobbyCode, matchState);
                }
            }
            return matchState;
        }

        public MatchState FindMatch(string lobbyCode)
        {
            MatchState matchState;
            lock (_matchesByLobbyCode)
            {
                _matchesByLobbyCode.TryGetValue(lobbyCode, out matchState);
            }
            return matchState;
        }
    }
}
