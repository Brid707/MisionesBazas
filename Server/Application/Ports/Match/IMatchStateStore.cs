using System;
using Application.Models;

namespace Application.Ports
{
    /// <summary>Stores one authoritative match per lobby without exposing it to transport clients.</summary>
    public interface IMatchStateStore
    {
        MatchState GetOrCreateMatch(string lobbyCode, Func<MatchState> createMatch);
        MatchState FindMatch(string lobbyCode);
        System.Collections.Generic.IReadOnlyList<System.Collections.Generic.KeyValuePair<string, MatchState>>
            GetMatches();
    }
}
