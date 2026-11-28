using System;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.ViewModels;

namespace ViewModel.Services
{
    /// <summary>
    /// Groups core UI navigation, dialog, and logging collaborators without exceeding three constructor parameters.
    /// </summary>
    public sealed class ViewModelUiServices
    {
        public ViewModelUiServices(INavigationService navigationService, IDialogService dialogService,
            ILoggerService logger)
        {
            NavigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            DialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            Logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public PlayerProfileCommands PlayerProfiles { get; set; } = new PlayerProfileCommands(null, false);

        public INavigationService NavigationService { get; }

        public IDialogService DialogService { get; }

        public ILoggerService Logger { get; }
    }
}
