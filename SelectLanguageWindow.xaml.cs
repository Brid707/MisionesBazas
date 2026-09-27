using System;
using System.Windows;

namespace MisionesBazas
{
    public partial class SelectLanguageWindow : Window
    {
        public SelectLanguageWindow()
        {
            InitializeComponent();
        }

        private void BtnClose_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void BtnSpanish_Click(object sender, RoutedEventArgs e)
        {
            LocalizationManager.Instance.SetCulture("es-MX");
            this.Close();
        }

        private void BtnEnglish_Click(object sender, RoutedEventArgs e)
        {
            LocalizationManager.Instance.SetCulture("en-US");
            this.Close();
        }
    }
}
