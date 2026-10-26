using System;
using System.Diagnostics;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for the main desktop host application window.
    /// </summary>
    public partial class MainWindow : Window
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="MainWindow"/> class.
        /// </summary>
        public MainWindow()
        {
            InitializeComponent();

            try
            {
                HomeScreen homePage = new HomeScreen();
                MainFrame.Navigate(homePage);
            }
            catch (InvalidOperationException ex)
            {
                // TODO: Replace Debug.WriteLine with project logger once logging infrastructure is available.
                Debug.WriteLine($"[MainWindow] Failed to navigate to HomeScreen: {ex.Message}");
            }
        }
    }
}
