namespace Application.Models
{
    /// <summary>
    /// Groups a validated participant seat, identifier, and distress signal request for action dispatching.
    /// </summary>
    internal sealed record DistressParticipantAction(DistressSignalRequest Request, byte ParticipantSeat,
        int ParticipantUserId);
}
