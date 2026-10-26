using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the game rules and guide window.
    /// </summary>
    public partial class HowToPlay : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="HowToPlay"/> class.
        /// </summary>
        public HowToPlay()
        {
            InitializeComponent();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
