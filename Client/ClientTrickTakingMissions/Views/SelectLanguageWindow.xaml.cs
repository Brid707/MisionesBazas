using System;
using System.Windows;

namespace View.Views
{
    /// <summary>
    /// Interaction logic for selecting application language culture.
    /// </summary>
    public partial class SelectLanguageWindow : Window
    {
        private const string SpanishCultureCode = "es-MX";
        private const string EnglishCultureCode = "en-US";

        /// <summary>
        /// Initializes a new instance of the <see cref="SelectLanguageWindow"/> class.
        /// </summary>
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
            ChangeLanguage(SpanishCultureCode);
        }

        private void BtnEnglish_Click(object sender, RoutedEventArgs e)
        {
            ChangeLanguage(EnglishCultureCode);
        }

        private void ChangeLanguage(string cultureCode)
        {
            View.Properties.Settings.Default.LanguageCode = cultureCode;
            View.Properties.Settings.Default.Save();

            App.ApplyCulture(cultureCode);

            this.Close();
        }
    }
}
