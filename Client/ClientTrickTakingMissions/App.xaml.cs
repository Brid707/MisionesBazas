using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;

namespace View
{
    /// <summary>
    /// Interaction logic for the WPF application entry point.
    /// </summary>
    public partial class App : Application
    {
        public Model.Services.IProfileImageCache ProfileImages { get; } = new Model.Services.ProfileImageCache(
            new Model.Services.ProfileImageClient(ConfigurationManager.AppSettings["ProfileImageEndpointAddress"] ??
                "net.tcp://localhost:8090/ProfileImageService"));

        protected override void OnExit(ExitEventArgs e)
        {
            ProfileImages.Dispose();
            base.OnExit(e);
        }

        /// <summary>
        /// Applies the specified culture code to the current UI threads and resource manager.
        /// </summary>
        /// <param name="languageCode">The culture code (e.g., 'es-MX', 'en-US') to activate.</param>
        public static void ApplyCulture(string languageCode)
        {
            if (!string.IsNullOrEmpty(languageCode))
            {
                var culture = new CultureInfo(languageCode);
                Thread.CurrentThread.CurrentCulture = culture;
                Thread.CurrentThread.CurrentUICulture = culture;
                CultureInfo.DefaultThreadCurrentCulture = culture;
                CultureInfo.DefaultThreadCurrentUICulture = culture;
                View.Properties.Langs.Resources.Culture = culture;
            }
        }

        /// <summary>
        /// Handles application startup and sets up user localization settings.
        /// </summary>
        /// <param name="e">A StartupEventArgs that contains the event data.</param>
        protected override void OnStartup(StartupEventArgs e)
        {
            var languageCode = View.Properties.Settings.Default.LanguageCode;
            ApplyCulture(languageCode);

            base.OnStartup(e);
        }
    }
}
