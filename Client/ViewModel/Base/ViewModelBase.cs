using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace ViewModel.Base
{
    /// <summary>
    /// Base class for all ViewModels, implementing INotifyPropertyChanged to support WPF Data Binding.
    /// </summary>
    public abstract class ViewModelBase : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Raises the PropertyChanged event for the specified property name.
        /// </summary>
        /// <param name="propertyName">The name of the property that changed. Automatically supplied by [CallerMemberName].</param>
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        /// <summary>
        /// Sets a property field and raises PropertyChanged if the value changed.
        /// </summary>
        /// <typeparam name="T">The type of the property.</typeparam>
        /// <param name="storage">Reference to the backing field.</param>
        /// <param name="value">New value to set.</param>
        /// <param name="propertyName">The name of the property. Automatically supplied by [CallerMemberName].</param>
        /// <returns>True if the value was changed, false if it was already equal.</returns>
        protected virtual bool SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null)
        {
            bool isValueChanged;

            if (Equals(storage, value))
            {
                isValueChanged = false;
            }
            else
            {
                isValueChanged = true;
                storage = value;
                OnPropertyChanged(propertyName);
            }

            return isValueChanged;
        }
    }
}
