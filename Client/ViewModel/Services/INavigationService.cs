namespace ViewModel.Services
{
    /// <summary>
    /// Service interface to decouple navigation logic from WPF Page/Window instances using integer view identifiers.
    /// </summary>
    public interface INavigationService
    {
        /// <summary>
        /// Navigates to a specific primary page identified by its integer constant from <see cref="Constants.ViewId"/>.
        /// </summary>
        /// <param name="viewId">The integer identifier of the target view.</param>
        void NavigateTo(int viewId);

        /// <summary>
        /// Navigates back in the navigation history, or returns to the home screen if at root.
        /// </summary>
        void GoBack();

        /// <summary>
        /// Displays a view as a modal dialog window identified by its integer constant from <see cref="Constants.ViewId"/>.
        /// </summary>
        /// <param name="dialogId">The integer identifier of the target dialog.</param>
        void ShowDialog(int dialogId);
    }
}
