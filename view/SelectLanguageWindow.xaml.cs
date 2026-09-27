using System;
using System.Threading;
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
            ChangeLanguage("es-MX");
        }

        private void BtnEnglish_Click(object sender, RoutedEventArgs e)
        {
            ChangeLanguage("en-US");
        }

        private void ChangeLanguage(string cultureCode)
        {
            Properties.Settings.Default.languageCode = cultureCode;
            Properties.Settings.Default.Save();

            var culture = new System.Globalization.CultureInfo(cultureCode);
            Thread.CurrentThread.CurrentUICulture = culture;
            Thread.CurrentThread.CurrentCulture = culture;
            System.Globalization.CultureInfo.DefaultThreadCurrentCulture = culture;
            System.Globalization.CultureInfo.DefaultThreadCurrentUICulture = culture;

            Properties.Langs.Resources.Culture = culture;

            this.Close();
        }
    }
}
