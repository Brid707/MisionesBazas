using System;
using System.Windows.Input;

namespace ViewModel.Base
{
    /// <summary>
    /// An implementation of ICommand based on the classic MVVM pattern.
    /// Delegates execution logic to Action and Predicate delegates.
    /// </summary>
    public class RelayCommand : ICommand
    {
        private readonly Action<object> _execute;
        private readonly Predicate<object> _canExecute;

        /// <summary>
        /// Occurs when changes occur that affect whether or not the command should execute.
        /// Hooks into WPF's CommandManager to automatically re-evaluate CanExecute when the UI state changes.
        /// </summary>
        public event EventHandler CanExecuteChanged
        {
            add => CommandManager.RequerySuggested += value;
            remove => CommandManager.RequerySuggested -= value;
        }

        /// <summary>
        /// Initializes a new instance of the RelayCommand with parameter support.
        /// </summary>
        /// <param name="execute">The action to execute.</param>
        /// <param name="canExecute">The predicate that determines if the action can execute.</param>
        public RelayCommand(Action<object> execute, Predicate<object> canExecute = null)
        {
            _execute = execute ?? throw new ArgumentNullException(nameof(execute));
            _canExecute = canExecute;
        }

        /// <summary>
        /// Initializes a new instance of the RelayCommand without parameters.
        /// </summary>
        /// <param name="execute">The parameterless action to execute.</param>
        /// <param name="canExecute">The parameterless function that determines if the action can execute.</param>
        public RelayCommand(Action execute, Func<bool> canExecute = null)
            : this(_ => execute(), canExecute == null ? (Predicate<object>)null : _ => canExecute())
        {
            if (execute == null)
            {
                throw new ArgumentNullException(nameof(execute));
            }
        }

        /// <summary>
        /// Determines whether the command can execute in its current state.
        /// </summary>
        public bool CanExecute(object parameter)
        {
            return _canExecute == null || _canExecute(parameter);
        }

        /// <summary>
        /// Executes the command action.
        /// </summary>
        public void Execute(object parameter)
        {
            _execute(parameter);
        }

        /// <summary>
        /// Manually requests the CommandManager to re-evaluate the CanExecute status.
        /// </summary>
        public void RaiseCanExecuteChanged()
        {
            CommandManager.InvalidateRequerySuggested();
        }
    }
}
