using System;
using System.Windows.Input;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for validating and processing match invitation code inputs.
    /// </summary>
    public sealed class EnterGameCodeViewModel : ViewModelBase
    {
        private readonly IDialogService _dialogService;
        private string _gameCode;

        /// <summary>
        /// Occurs when the dialog requests to close, passing a boolean indicating whether the code was confirmed.
        /// </summary>
        public event Action<bool> RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="EnterGameCodeViewModel"/> class.
        /// </summary>
        /// <param name="dialogService">Service for presenting modal feedback alerts.</param>
        public EnterGameCodeViewModel(IDialogService dialogService)
        {
            _dialogService = dialogService ?? throw new ArgumentNullException(nameof(dialogService));
            _gameCode = string.Empty;

            CloseCommand = new RelayCommand(ExecuteClose);
            JoinCommand = new RelayCommand(ExecuteJoin);
        }

        /// <summary>
        /// Gets or sets the match code entered by the user.
        /// </summary>
        public string GameCode
        {
            get => _gameCode;
            set => SetProperty(ref _gameCode, value);
        }

        /// <summary>
        /// Gets the command that dismisses the dialog without joining.
        /// </summary>
        public ICommand CloseCommand { get; }

        /// <summary>
        /// Gets the command that validates the game code and attempts to join the room.
        /// </summary>
        public ICommand JoinCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke(false);
        }

        private void ExecuteJoin()
        {
            if (string.IsNullOrWhiteSpace(_gameCode))
            {
                _dialogService.ShowWarning(MessageCode.EnterGameCodeEmptyCode);
            }
            else
            {
                RequestClose?.Invoke(true);
            }
        }
    }
}
