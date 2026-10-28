using System;
using System.Diagnostics;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for configuring match rules and game settings.
    /// Acts as a modal dialog that returns confirmation to the parent view.
    /// </summary>
    public partial class GameSettings : Window
    {
        private const int MinimumPlayerCount = 3;
        private const int MaximumPlayerCount = 4;
        private const int DefaultPlayerSelectionIndex = 1;
        private const int MinimumMissionCount = 1;
        private const int MaximumMissionCount = 50;
        private const int DefaultMissionSelectionIndex = 4;

        /// <summary>
        /// Initializes a new instance of the <see cref="GameSettings"/> class.
        /// </summary>
        public GameSettings()
        {
            InitializeComponent();

            PlayersComboBox.Items.Clear();
            PlayersComboBox.Items.Add(MinimumPlayerCount);
            PlayersComboBox.Items.Add(MaximumPlayerCount);
            PlayersComboBox.SelectedIndex = DefaultPlayerSelectionIndex;

            MissionsComboBox.Items.Clear();
            for (int missionNumber = MinimumMissionCount; missionNumber <= MaximumMissionCount; missionNumber++)
            {
                MissionsComboBox.Items.Add(missionNumber);
            }
            MissionsComboBox.SelectedIndex = DefaultMissionSelectionIndex;

            RadioPrivate.IsChecked = true;
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void ConfirmButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
            this.Close();
        }
    }
}
