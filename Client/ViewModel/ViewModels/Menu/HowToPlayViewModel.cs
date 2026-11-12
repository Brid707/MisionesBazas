using System;
using System.Windows.Input;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for managing the game guide and rules dialog presentation.
    /// </summary>
    public sealed class HowToPlayViewModel : ViewModelBase
    {
        /// <summary>
        /// Occurs when the dialog requests to close.
        /// </summary>
        public event Action RequestClose;

        /// <summary>
        /// Initializes a new instance of the <see cref="HowToPlayViewModel"/> class.
        /// </summary>
        public HowToPlayViewModel()
        {
            CloseCommand = new RelayCommand(ExecuteClose);
        }

        /// <summary>
        /// Gets the command that dismisses the rules dialog.
        /// </summary>
        public ICommand CloseCommand { get; }

        private void ExecuteClose()
        {
            RequestClose?.Invoke();
        }
    }
}
