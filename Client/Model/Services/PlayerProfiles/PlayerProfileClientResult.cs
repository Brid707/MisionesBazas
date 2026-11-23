using PlayerProfiles;

namespace Model.Services
{
    /// <summary>Separates confirmed server data from public failures and uncertain write delivery.</summary>
    public sealed class PlayerProfileClientResult
    {
        public PlayerProfileDetails Profile { get; set; }

        public string SavedBiography { get; set; }

        public PlayerProfileFailureReason? FailureReason { get; set; }

        public bool IsSaveUnconfirmed { get; set; }

        public bool IsSuccessful => !FailureReason.HasValue;
    }
}
