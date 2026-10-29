using System;
using System.Collections.Generic;
using System.Windows.Input;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for configuring match rules, player limits, missions, and lobby privacy.
    /// </summary>
    public sealed class GameSettingsViewModel : ViewModelBase
    {
        private const int MinimumPlayerCount = 3;
        private const int MaximumPlayerCount = 4;
        private const int MinimumMissionCount = 1;
        private const int MaximumMissionCount = 50;

        private int _selectedPlayerCount;
        private int _selectedMissionCount;
        private bool _isPrivate;

        /// <summary>
        /// Occurs when the dialog requests to close, passing a boolean indicating whether settings were confirmed.
        /// </summary>
        public event Action<bool> RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="GameSettingsViewModel"/> class.
        /// </summary>
        public GameSettingsViewModel()
        {
            AvailablePlayerCounts = new List<int> { MinimumPlayerCount, MaximumPlayerCount };
            _selectedPlayerCount = MaximumPlayerCount;

            AvailableMissionCounts = new List<int>();
            for (int i = MinimumMissionCount; i <= MaximumMissionCount; i++)
            {
                AvailableMissionCounts.Add(i);
            }
            _selectedMissionCount = 5;

            _isPrivate = true;

            CloseCommand = new RelayCommand(ExecuteClose);
            ConfirmCommand = new RelayCommand(ExecuteConfirm);
        }

        /// <summary>
        /// Gets the list of valid player counts allowed in a match.
        /// </summary>
        public List<int> AvailablePlayerCounts { get; }

        /// <summary>
        /// Gets or sets the selected maximum player count.
        /// </summary>
        public int SelectedPlayerCount
        {
            get => _selectedPlayerCount;
            set => SetProperty(ref _selectedPlayerCount, value);
        }

        /// <summary>
        /// Gets the list of selectable mission targets.
        /// </summary>
        public List<int> AvailableMissionCounts { get; }

        /// <summary>
        /// Gets or sets the chosen mission target count.
        /// </summary>
        public int SelectedMissionCount
        {
            get => _selectedMissionCount;
            set => SetProperty(ref _selectedMissionCount, value);
        }

        /// <summary>
        /// Gets or sets a value indicating whether the lobby is private (invitation/code only) or public.
        /// </summary>
        public bool IsPrivate
        {
            get => _isPrivate;
            set => SetProperty(ref _isPrivate, value);
        }

        /// <summary>
        /// Gets the command that cancels settings configuration.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that confirms game rules and saves lobby parameters.
        /// </summary>
        public ICommand ConfirmCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private void ExecuteConfirm()
        {
            RequestClose?.Invoke(true);
        }
    }
}
