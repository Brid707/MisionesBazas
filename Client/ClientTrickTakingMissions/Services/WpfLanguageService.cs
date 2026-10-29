using ViewModel.Services;

namespace View.Services
{
    /// <summary>
    /// WPF implementation of <see cref="ILanguageService"/> that persists user culture preferences.
    /// </summary>
    public sealed class WpfLanguageService : ILanguageService
    {
        /// <summary>
        /// Gets the culture code currently saved in user settings.
        /// </summary>
        public string CurrentCultureCode => View.Properties.Settings.Default.LanguageCode;

        /// <summary>
        /// Applies the requested culture code to the WPF application and persists the user preference.
        /// </summary>
        /// <param name="cultureCode">The culture code identifier (e.g. "es-MX", "en-US").</param>
        public void ChangeLanguage(string cultureCode)
        {
            View.Properties.Settings.Default.LanguageCode = cultureCode;
            View.Properties.Settings.Default.Save();

            App.ApplyCulture(cultureCode);
        }
    }
}
