using TrickTakingMissions.Rules.Enums;

namespace TrickTakingMissions.Rules.Models
{
    /// <summary>
    /// Represents the validation outcome for an attempted card play in a trick.
    /// </summary>
    public sealed record TrickPlayValidationResult
    {
        public bool IsLegal { get; init; }

        public TrickPlayRejectionReason RejectionReason { get; init; }

        public static TrickPlayValidationResult Legal()
        {
            return new TrickPlayValidationResult
            {
                IsLegal = true,
                RejectionReason = TrickPlayRejectionReason.None
            };
        }

        public static TrickPlayValidationResult Illegal(TrickPlayRejectionReason rejectionReason)
        {
            return new TrickPlayValidationResult
            {
                IsLegal = false,
                RejectionReason = rejectionReason
            };
        }
    }
}
