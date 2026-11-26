using Model.GameServices;

namespace ViewModel.ViewModels
{
    /// <summary>Labels an allowed marker without importing presentation types into the view model.</summary>
    public sealed class RadioMarkerOptionViewModel
    {
        public RadioMarkerOptionViewModel(RadioCommunicationMarker marker)
        {
            Marker = marker;
        }

        public RadioCommunicationMarker Marker { get; }
        public string ResourceKey => "Radio_Marker_" + Marker;
    }
}
