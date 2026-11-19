namespace ViewModel.ViewModels
{
    /// <summary>Displays only a participant's voluntary response, without their private cards.</summary>
    public sealed class BlindObjectiveResponseViewModel
    {
        public BlindObjectiveResponseViewModel(string participantName, string responseResourceKey)
        {
            ParticipantName = participantName;
            ResponseResourceKey = responseResourceKey;
        }

        public string ParticipantName { get; }
        public string ResponseResourceKey { get; }
    }
}
