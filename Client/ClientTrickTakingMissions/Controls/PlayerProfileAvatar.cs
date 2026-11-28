using System.Windows;
using System.Windows.Controls;
using ViewModel.ViewModels;

namespace View.Controls
{
    /// <summary>Displays a shared cached avatar and releases observation when removed from the visual tree.</summary>
    public sealed class PlayerProfileAvatar : ContentControl
    {
        public static readonly DependencyProperty ProfileOwnerUserIdProperty = DependencyProperty.Register(
            nameof(ProfileOwnerUserId), typeof(int), typeof(PlayerProfileAvatar),
            new PropertyMetadata(0, OnProfileOwnerChanged));

        private ProfileImageViewModel _profileImage;

        public PlayerProfileAvatar()
        {
            SetResourceReference(ContentTemplateProperty, "ProfileAvatarTemplate");
            Loaded += OnAvatarLoaded;
            Unloaded += OnAvatarUnloaded;
        }

        public int ProfileOwnerUserId
        {
            get => (int)GetValue(ProfileOwnerUserIdProperty);
            set => SetValue(ProfileOwnerUserIdProperty, value);
        }

        private static void OnProfileOwnerChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
        {
            ((PlayerProfileAvatar)sender).RefreshImageObservation();
        }

        private void OnAvatarLoaded(object sender, RoutedEventArgs e)
        {
            if (ReferenceEquals(e.OriginalSource, this))
            {
                RefreshImageObservation();
            }
        }

        private void OnAvatarUnloaded(object sender, RoutedEventArgs e)
        {
            if (ReferenceEquals(e.OriginalSource, this))
            {
                ReleaseImageObservation();
            }
        }

        private void RefreshImageObservation()
        {
            ReleaseImageObservation();
            if (IsLoaded && ProfileOwnerUserId > 0 && Application.Current is App application &&
                application.ProfileImages != null)
            {
                _profileImage = new ProfileImageViewModel(ProfileOwnerUserId, application.ProfileImages);
                Content = _profileImage;
            }
        }

        private void ReleaseImageObservation()
        {
            _profileImage?.Dispose();
            _profileImage = null;
            Content = null;
        }
    }
}
