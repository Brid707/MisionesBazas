using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing user selection between available languages (Spanish / English).
    /// </summary>
    public sealed class SelectLanguageViewModel : ViewModelBase
    {
        private const string SpanishCultureCode = "es-MX";
        private const string EnglishCultureCode = "en-US";

        private readonly ILanguageService _languageService;

        /// <summary>
        /// Occurs when the dialog requests to be closed following a selection or cancel action.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="SelectLanguageViewModel"/> class with the language service.
        /// </summary>
        /// <param name="languageService">The language management service.</param>
        public SelectLanguageViewModel(ILanguageService languageService)
        {
            _languageService = languageService ?? throw new ArgumentNullException(nameof(languageService));

            SelectSpanishCommand = new RelayCommand(ExecuteSelectSpanish);
            SelectEnglishCommand = new RelayCommand(ExecuteSelectEnglish);
            CloseCommand = new RelayCommand(ExecuteClose);
        }

        /// <summary>
        /// Gets the command that sets the application language to Spanish.
        /// </summary>
        public ICommand SelectSpanishCommand { get; }

        /// <summary>
        /// Gets the command that sets the application language to English.
        /// </summary>
        public ICommand SelectEnglishCommand { get; }

        /// <summary>
        /// Gets the command that dismisses the language selection dialog.
        /// </summary>
        public ICommand CloseCommand { get; }

        private void ExecuteSelectSpanish()
        {
            _languageService.ChangeLanguage(SpanishCultureCode);
            RequestClose?.Invoke();
        }

        private void ExecuteSelectEnglish()
        {
            _languageService.ChangeLanguage(EnglishCultureCode);
            RequestClose?.Invoke();
        }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }
    }
}
