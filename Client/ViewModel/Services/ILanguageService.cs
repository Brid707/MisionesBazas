namespace ViewModel.Services
{
    /// <summary>
    /// Service for applying and persisting application localization culture codes.
    /// </summary>
    public interface ILanguageService
    {
        /// <summary>
        /// Gets the currently configured culture code.
        /// </summary>
        string CurrentCultureCode { get; }

        /// <summary>
        /// Changes the active application language culture and persists the setting.
        /// </summary>
        /// <param name="cultureCode">The culture code identifier (e.g. "es-MX", "en-US").</param>
        void ChangeLanguage(string cultureCode);
    }
}
