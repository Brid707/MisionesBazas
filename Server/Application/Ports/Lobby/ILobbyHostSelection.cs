using System.Collections.Generic;

namespace Application.Ports
{
    /// <summary>Selects one host identifier from the remaining eligible participants.</summary>
    public interface ILobbyHostSelection
    {
        /// <summary>Selects one eligible identifier without modifying the room.</summary>
        /// <param name="eligibleParticipantUserIds">The remaining eligible participant identifiers.</param>
        /// <returns>A supplied identifier, or zero when the collection is empty.</returns>
        int SelectHostUserId(IReadOnlyList<int> eligibleParticipantUserIds);
    }
}
