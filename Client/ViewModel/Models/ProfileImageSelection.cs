using ViewModel.Constants;

namespace ViewModel.Models
{
    /// <summary>
    /// Reports selected image bytes or an expected validation outcome without throwing for user input.
    /// </summary>
    public sealed class ProfileImageSelection
    {
        public byte[] SelectedProfileImageBytes { get; set; }

        public ProfileImageFeedback SelectionFeedback { get; set; }
    }
}
