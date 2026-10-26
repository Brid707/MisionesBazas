using System;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for managing pending and sent friend requests.
    /// </summary>
    public partial class ManageFriendRequest : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ManageFriendRequest"/> class.
        /// </summary>
        public ManageFriendRequest()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            LoadFriendRequests();
        }

        private void LoadFriendRequests()
        {
            // TODO: Load friend requests from backend service.
        }

        private void BtnAcceptSample_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Accept friend request via backend service.
        }

        private void BtnRejectSample_Click(object sender, RoutedEventArgs e)
        {
            // TODO: Reject friend request via backend service.
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
