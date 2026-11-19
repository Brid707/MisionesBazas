using Gameplay;

namespace ViewModel.ViewModels
{
    /// <summary>Presents only the voluntarily revealed card and the server-approved public marker.</summary>
    public sealed class PlayerRadioCommunicationViewModel
    {
        public PlayerRadioCommunicationViewModel(PlayerRadioCommunicationSnapshot snapshot, string participantName)
        {
            ParticipantName = participantName;
            CardId = snapshot.CommunicatedCardId;
            Marker = snapshot.Marker;
            HasCommunicatedCardBeenPlayed = snapshot.HasCommunicatedCardBeenPlayed;
        }

        public string ParticipantName { get; }
        public int CardId { get; }
        public RadioCommunicationMarker Marker { get; }
        public bool HasCommunicatedCardBeenPlayed { get; }
        public string MarkerResourceKey => "Radio_Marker_" + Marker;
    }
}
