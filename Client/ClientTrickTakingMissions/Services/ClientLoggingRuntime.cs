using System;
using System.ComponentModel;
using System.Windows;
using TrickTakingMissions.Logging.Abstractions;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Services;
using ViewModel.ViewModels;

namespace View.Services
{
    /// <summary>
    /// Exposes the logger factory configured at the WPF composition root.
    /// </summary>
    internal static class ClientLoggingRuntime
    {
        private const string RuntimeNotInitializedMessage =
            "ClientLoggingRuntime must be initialized during App.OnStartup before creating views.";

        private static readonly object s_syncRoot = new object();
        private static readonly DependencyObject s_designModeProbe = new DependencyObject();
        private static ILoggerFactory s_loggerFactory;

        public static void Initialize(ILoggerFactory loggerFactory)
        {
            if (loggerFactory == null)
            {
                throw new ArgumentNullException(nameof(loggerFactory));
            }

            lock (s_syncRoot)
            {
                s_loggerFactory = loggerFactory;
            }
        }

        public static ILoggerService CreateLogger<TCaller>()
        {
            lock (s_syncRoot)
            {
                if (s_loggerFactory != null)
                {
                    return s_loggerFactory.CreateLogger<TCaller>();
                }
            }

            if (DesignerProperties.GetIsInDesignMode(s_designModeProbe))
            {
                return NullLoggerService.Instance;
            }

            throw new InvalidOperationException(RuntimeNotInitializedMessage);
        }

        public static PlayerProfileCommands CreatePlayerProfileCommands(bool allowsGuestLobbyAccess)
        {
            return new PlayerProfileCommands(new WpfPlayerProfileNavigation(), allowsGuestLobbyAccess);
        }

        public static ViewModelUiServices CreateUiServices<TCaller>()
        {
            return new ViewModelUiServices(
                new WpfNavigationService(),
                new WpfDialogService(),
                CreateLogger<TCaller>())
            {
                PlayerProfiles = CreatePlayerProfileCommands(false)
            };
        }

        public static ViewModelNavigationLogging CreateNavigationLogging<TCaller>()
        {
            return new ViewModelNavigationLogging(
                new WpfNavigationService(),
                CreateLogger<TCaller>())
            {
                PlayerProfiles = CreatePlayerProfileCommands(true)
            };
        }
    }
}
