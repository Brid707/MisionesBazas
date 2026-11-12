using System.Windows;
using System.Windows.Controls;
using Model.Session;
using View.Services;
using ViewModel.ViewModels;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the friends sidebar control.
    /// Reusable view dynamically embedded in GameMenu and Lobby.
    /// </summary>
    public partial class FriendsView : UserControl
    {
        /// <summary>
        /// Identifies the <see cref="IsInLobby"/> dependency property.
        /// </summary>
        public static readonly DependencyProperty IsInLobbyProperty =
            DependencyProperty.Register(
                nameof(IsInLobby),
                typeof(bool),
                typeof(FriendsView),
                new PropertyMetadata(false, OnIsInLobbyChanged));

        /// <summary>
        /// Identifies the <see cref="InviteButtonVisibility"/> dependency property.
        /// </summary>
        public static readonly DependencyProperty InviteButtonVisibilityProperty =
            DependencyProperty.Register(
                nameof(InviteButtonVisibility),
                typeof(Visibility),
                typeof(FriendsView),
                new PropertyMetadata(Visibility.Collapsed));

        private readonly FriendsViewModel _viewModel;

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendsView"/> class.
        /// </summary>
        public FriendsView()
        {
            InitializeComponent();

            _viewModel = new FriendsViewModel(
                ClientLoggingRuntime.CreateUiServices<FriendsViewModel>(),
                FriendshipSession.Current,
                LobbySession.Current);
            DataContext = _viewModel;
        }

        /// <summary>
        /// Gets or sets a value indicating whether this view is embedded in the Lobby screen.
        /// </summary>
        public bool IsInLobby
        {
            get => (bool)GetValue(IsInLobbyProperty);
            set => SetValue(IsInLobbyProperty, value);
        }

        /// <summary>
        /// Gets or sets the visibility of the invite-to-match button on friend cards.
        /// </summary>
        public Visibility InviteButtonVisibility
        {
            get => (Visibility)GetValue(InviteButtonVisibilityProperty);
            set => SetValue(InviteButtonVisibilityProperty, value);
        }

        private static void OnIsInLobbyChanged(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
            if (d is FriendsView friendsView)
            {
                bool isInLobby = (bool)e.NewValue;
                friendsView.InviteButtonVisibility = isInLobby ? Visibility.Visible : Visibility.Collapsed;
                if (friendsView._viewModel != null)
                {
                    friendsView._viewModel.IsInLobby = isInLobby;
                }
            }
        }
    }
}
