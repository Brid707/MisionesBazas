using System;
using System.Windows;
using System.Windows.Data;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for displaying leaderboard and user experience rankings.
    /// </summary>
    public partial class ScoreBoard : Window
    {
        private CollectionViewSource _userViewSource;

        /// <summary>
        /// Initializes a new instance of the <see cref="ScoreBoard"/> class.
        /// </summary>
        public ScoreBoard()
        {
            InitializeComponent();
            _userViewSource = (CollectionViewSource)this.FindResource("userViewSource");
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // TODO: Populate userViewSource with ranking data from backend service.
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Raises the <see cref="Window.Closed"/> event.
        /// </summary>
        /// <param name="e">An <see cref="EventArgs"/> that contains the event data.</param>
        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
        }
    }
}
