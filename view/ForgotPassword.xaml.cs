using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MisionesBazas.view
{

    public partial class ForgotPassword : Window
    {
        public ForgotPassword()
        {
            InitializeComponent();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void SendButton_Click(object sender, RoutedEventArgs e)
        {
            string email = EmailTextBox.Text?.Trim() ?? string.Empty;
            MainBorder.Visibility = Visibility.Collapsed;
            ContentFrame.Visibility = Visibility.Visible;
            ContentFrame.Navigate(new RecoverPassword(email));
        }

        public void ShowInitialView()
        {
            ContentFrame.Content = null;
            ContentFrame.Visibility = Visibility.Collapsed;
            MainBorder.Visibility = Visibility.Visible;
        }
    }
}
