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
    public partial class RecoverPassword : Page
    {
        public RecoverPassword()
        {
            InitializeComponent();
        }

        public RecoverPassword(string email) : this()
        {
            if (!string.IsNullOrEmpty(email))
            {
                EmailTextBox.Text = email;
            }
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            var parent = Window.GetWindow(this) as ForgotPassword;
            if (parent != null)
            {
                parent.ShowInitialView();
            }
            else if (this.NavigationService != null && this.NavigationService.CanGoBack)
            {
                this.NavigationService.GoBack();
            }
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            Window.GetWindow(this)?.Close();
        }

        private void ReenviarButton_Click(object sender, RoutedEventArgs e)
        {
        }

        private void ConfirmButton_Click(object sender, RoutedEventArgs e)
        {
            var owner = Window.GetWindow(this);
            var change = new ChangePassword();
            if (owner != null)
            {
                change.Owner = owner;
                change.WindowStartupLocation = WindowStartupLocation.CenterOwner;
            }
            change.ShowDialog();
        }
    }
}

