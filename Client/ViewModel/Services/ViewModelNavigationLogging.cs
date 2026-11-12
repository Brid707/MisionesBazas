using System;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace ViewModel.Services
{
    /// <summary>
    /// Groups UI navigation and logging collaborators for ViewModels without modal dialog dependency.
    /// </summary>
    public sealed class ViewModelNavigationLogging
    {
        public ViewModelNavigationLogging(INavigationService navigationService, ILoggerService logger)
        {
            NavigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            Logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public INavigationService NavigationService { get; }

        public ILoggerService Logger { get; }
    }
}
