namespace TrickTakingMissions.Rules.Rules
{
    /// <summary>Bounds exact account-profile lookup using the existing Username NVARCHAR(50) capacity.</summary>
    public static class PlayerProfileLookupRules
    {
        public const int MaximumProfileUsernameLength = 50;

        public static bool IsProfileLookupValid(int profileOwnerUserId, string profileOwnerUsername)
        {
            bool isLookupById = profileOwnerUserId > 0 && string.IsNullOrEmpty(profileOwnerUsername);
            bool isLookupByUsername = profileOwnerUserId == 0 && !string.IsNullOrWhiteSpace(profileOwnerUsername) &&
                profileOwnerUsername.Length <= MaximumProfileUsernameLength;
            return isLookupById || isLookupByUsername;
        }
    }
}
