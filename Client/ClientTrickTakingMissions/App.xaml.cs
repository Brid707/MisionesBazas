using System;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Threading;
using Model.Services;
using Model.Session;
using TrickTakingMissions.Logging;
using TrickTakingMissions.Logging.Abstractions.Ports;
using View.Services;

namespace View
{
    /// <summary>
    /// Interaction logic for the WPF application entry point.
    /// </summary>
    public partial class App : Application
    {
        private const string ApplicationFolderName = "TrickTakingMissions";
        private const string LogsFolderName = "Logs";
        private const string ClientLogFileName = "ClientTrickTakingMissions.log";
        private const string ProfileImageEndpointSettingKey = "ProfileImageEndpointAddress";
        private const string DefaultProfileImageEndpointAddress = "net.tcp://localhost:8090/ProfileImageService";
        private const string ClientStartedTemplate = "TrickTakingMissions desktop client started.";
        private const string ClientExitingTemplate =
            "TrickTakingMissions desktop client exiting with code {ExitCode}.";
        private const string DispatcherUnhandledTemplate = "Unhandled UI dispatcher exception occurred.";
        private const string AppDomainUnhandledTemplate =
            "Unhandled AppDomain exception occurred. IsTerminating: {IsTerminating}.";
        private const string UnobservedTaskTemplate = "Unobserved background task exception occurred.";

        private ILoggerService _applicationLogger;

        public IProfileImageCache ProfileImages { get; private set; }

        protected override void OnExit(ExitEventArgs e)
        {
            ProfileImages?.Dispose();

            if (_applicationLogger != null)
            {
                _applicationLogger.Information(ClientExitingTemplate, e.ApplicationExitCode);
            }

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
            ILoggerFactory loggerFactory = ConfigureClientLogging();
            InitializeProfileImageCache(loggerFactory);

            var languageCode = View.Properties.Settings.Default.LanguageCode;
            ApplyCulture(languageCode);

            _applicationLogger.Information(ClientStartedTemplate);
            base.OnStartup(e);
        }

        private ILoggerFactory ConfigureClientLogging()
        {
            string localAppDataPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
            string logsDirectory = Path.Combine(localAppDataPath, ApplicationFolderName, LogsFolderName);

            Log4NetConfigurator.Configure(logsDirectory, ClientLogFileName);

            ILoggerFactory loggerFactory = new LoggerFactory();
            ClientLoggingRuntime.Initialize(loggerFactory);
            LobbySession.Current.ConfigureLogging(loggerFactory);
            FriendshipSession.Current.ConfigureLogging(loggerFactory);

            _applicationLogger = loggerFactory.CreateLogger<App>();

            DispatcherUnhandledException += OnDispatcherUnhandledException;
            AppDomain.CurrentDomain.UnhandledException += OnCurrentDomainUnhandledException;
            TaskScheduler.UnobservedTaskException += OnUnobservedTaskException;

            return loggerFactory;
        }

        private void InitializeProfileImageCache(ILoggerFactory loggerFactory)
        {
            string endpointAddress = ConfigurationManager.AppSettings[ProfileImageEndpointSettingKey] ??
                DefaultProfileImageEndpointAddress;
            ProfileImageClient profileImageClient = new ProfileImageClient(
                endpointAddress,
                loggerFactory.CreateLogger<ProfileImageClient>());
            ProfileImages = new ProfileImageCache(profileImageClient);
        }

        private void OnDispatcherUnhandledException(object sender, DispatcherUnhandledExceptionEventArgs e)
        {
            _applicationLogger.Fatal(e.Exception, DispatcherUnhandledTemplate);
        }

        private void OnCurrentDomainUnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            Exception unhandledException = e.ExceptionObject as Exception;
            _applicationLogger.Fatal(unhandledException, AppDomainUnhandledTemplate, e.IsTerminating);
        }

        private void OnUnobservedTaskException(object sender, UnobservedTaskExceptionEventArgs e)
        {
            _applicationLogger.Error(e.Exception, UnobservedTaskTemplate);
            e.SetObserved();
        }
    }
}
