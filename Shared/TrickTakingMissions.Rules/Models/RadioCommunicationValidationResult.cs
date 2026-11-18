using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Encapsulates the result of a radio communication validation check.
    /// </summary>
    public sealed record RadioCommunicationValidationResult
    {
        public bool IsValid { get; init; }

        public RadioCommunicationRejectionReason RejectionReason { get; init; }

        public RadioTokenPosition ResolvedPosition { get; init; }

        public static RadioCommunicationValidationResult Success(RadioTokenPosition position)
        {
            return new RadioCommunicationValidationResult
            {
                IsValid = true,
                RejectionReason = RadioCommunicationRejectionReason.None,
                ResolvedPosition = position
            };
        }

        public static RadioCommunicationValidationResult Reject(RadioCommunicationRejectionReason reason)
        {
            return new RadioCommunicationValidationResult
            {
                IsValid = false,
                RejectionReason = reason,
                ResolvedPosition = RadioTokenPosition.None
            };
        }
    }
}
