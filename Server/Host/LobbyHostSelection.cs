using System;
using System.Collections.Generic;

using Application.Ports;

namespace Host
{
    /// <summary>Chooses uniformly among supplied participants using a synchronized random source.</summary>
    public sealed class LobbyHostSelection : ILobbyHostSelection
    {
        private readonly Random _hostSelectionRandom = new Random();
        private readonly object _hostSelectionLock = new object();

        public int SelectHostUserId(IReadOnlyList<int> eligibleParticipantUserIds)
        {
            int selectedHostUserId = 0;
            lock (_hostSelectionLock)
            {
                if (eligibleParticipantUserIds.Count > 0)
                {
                    selectedHostUserId = eligibleParticipantUserIds[
                        _hostSelectionRandom.Next(eligibleParticipantUserIds.Count)];
                }
            }

            return selectedHostUserId;
        }
    }
}
