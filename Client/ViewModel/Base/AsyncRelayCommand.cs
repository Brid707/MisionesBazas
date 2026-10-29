using System;
using System.Threading.Tasks;
using System.Windows.Input;

namespace ViewModel.Base
{
    /// <summary>
    /// An ICommand implementation for asynchronous actions that prevents re-entrant executions
    /// while a previous invocation is still running.
    /// </summary>
    public sealed class AsyncRelayCommand : ICommand
    {
        private readonly Func<Task> _executeAsync;
        private readonly Func<bool> _canExecute;
        private bool _isRunning;

        /// <summary>
        /// Initializes a new instance of the <see cref="AsyncRelayCommand"/> class.
        /// </summary>
        /// <param name="executeAsync">The asynchronous action to execute.</param>
        /// <param name="canExecute">The optional predicate that determines if the action can execute.</param>
        public AsyncRelayCommand(Func<Task> executeAsync, Func<bool> canExecute = null)
        {
            _executeAsync = executeAsync ?? throw new ArgumentNullException(nameof(executeAsync));
            _canExecute = canExecute;
        }

        public event EventHandler CanExecuteChanged
        {
            add => CommandManager.RequerySuggested += value;
            remove => CommandManager.RequerySuggested -= value;
        }

        public bool CanExecute(object parameter)
        {
            return !_isRunning && (_canExecute == null || _canExecute());
        }

        public void Execute(object parameter)
        {
            _ = RunAsync();
        }

        private async Task RunAsync()
        {
            _isRunning = true;
            CommandManager.InvalidateRequerySuggested();

            try
            {
                await _executeAsync();
            }
            finally
            {
                _isRunning = false;
                CommandManager.InvalidateRequerySuggested();
            }
        }
    }
}
