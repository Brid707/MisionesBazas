namespace ViewModel.ViewModels
{
    /// <summary>Displays only an authorized public role label and participant name.</summary>
    public sealed class PublicMissionRoleViewModel
    {
        public PublicMissionRoleViewModel(string labelResourceKey, string participantName)
        {
            LabelResourceKey = labelResourceKey;
            ParticipantName = participantName;
        }

        public string LabelResourceKey { get; }
        public string ParticipantName { get; }
    }
}
