using Model.Services;

namespace ViewModel.Models
{
    /// <summary>Groups profile-specific image and text adapters at the presentation composition boundary.</summary>
    public sealed class ProfileInteractionDependencies
    {
        public IProfileImageCache ProfileImages { get; set; }

        public IPlayerProfileClient PlayerProfileClient { get; set; }
    }
}
