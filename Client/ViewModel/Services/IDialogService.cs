namespace ViewModel.Services
{
    /// <summary>
    /// Service interface to decouple UI messages from ViewModels using integer codes from <see cref="Constants.MessageCode"/>.
    /// </summary>
    public interface IDialogService
    {
        /// <summary>
        /// Displays an informational alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier of the message to display.</param>
        void ShowInformation(int messageCode);

        /// <summary>
        /// Displays a warning alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier of the warning message to display.</param>
        void ShowWarning(int messageCode);

        /// <summary>
        /// Displays an error alert box mapped from an integer message code.
        /// </summary>
        /// <param name="messageCode">The integer identifier of the error message to display.</param>
        void ShowError(int messageCode);
    }
}
