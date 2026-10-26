using System;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for entering an invitation game code to join a match.
    /// </summary>
    public partial class EnterGameCode : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="EnterGameCode"/> class.
        /// </summary>
        public EnterGameCode()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Gets the trimmed code string entered by the user.
        /// </summary>
        public string GameCode => CodeTextBox?.Text?.Trim() ?? string.Empty;

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void EnterButton_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(GameCode))
            {
                this.DialogResult = true;
                this.Close();
            }
            else
            {
                MessageBox.Show(View.Properties.Langs.Resources.EnterGameCode_EmptyCode);
            }
        }
    }
}
