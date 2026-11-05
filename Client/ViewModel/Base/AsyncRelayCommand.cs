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
        private readonly Func<object, Task> _executeWithParameterAsync;
        private readonly Func<Task> _executeAsync;
        private readonly Predicate<object> _canExecuteWithParameter;
        private readonly Func<bool> _canExecute;
        private bool _isRunning;

        /// <summary>
        /// Initializes a new instance of the <see cref="AsyncRelayCommand"/> class without parameters.
        /// </summary>
        /// <param name="executeAsync">The asynchronous action to execute.</param>
        /// <param name="canExecute">The optional predicate that determines if the action can execute.</param>
        public AsyncRelayCommand(Func<Task> executeAsync, Func<bool> canExecute = null)
        {
            _executeAsync = executeAsync ?? throw new ArgumentNullException(nameof(executeAsync));
            _canExecute = canExecute;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AsyncRelayCommand"/> class with parameter support.
        /// </summary>
        /// <param name="executeWithParameterAsync">The parameterized asynchronous action to execute.</param>
        /// <param name="canExecuteWithParameter">The optional parameterized predicate.</param>
        public AsyncRelayCommand(
            Func<object, Task> executeWithParameterAsync,
            Predicate<object> canExecuteWithParameter = null)
        {
            _executeWithParameterAsync = executeWithParameterAsync
                ?? throw new ArgumentNullException(nameof(executeWithParameterAsync));
            _canExecuteWithParameter = canExecuteWithParameter;
        }

        public event EventHandler CanExecuteChanged
        {
            add => CommandManager.RequerySuggested += value;
            remove => CommandManager.RequerySuggested -= value;
        }

        public bool CanExecute(object parameter)
        {
            bool isAllowedByPredicate = true;

            if (_canExecuteWithParameter != null)
            {
                isAllowedByPredicate = _canExecuteWithParameter(parameter);
            }
            else if (_canExecute != null)
            {
                isAllowedByPredicate = _canExecute();
            }

            return !_isRunning && isAllowedByPredicate;
        }

        public void Execute(object parameter)
        {
            _ = RunAsync(parameter);
        }

        private async Task RunAsync(object parameter)
        {
            _isRunning = true;
            CommandManager.InvalidateRequerySuggested();

            try
            {
                if (_executeWithParameterAsync != null)
                {
                    await _executeWithParameterAsync(parameter);
                }
                else
                {
                    await _executeAsync();
                }
            }
            finally
            {
                _isRunning = false;
                CommandManager.InvalidateRequerySuggested();
            }
        }
    }
}
