namespace ViewModel.Services
{
    /// <summary>Opens a read-only player profile without leaving the active lobby or social view.</summary>
    public interface IPlayerProfileNavigation
    {
        void OpenProfileByUserId(int profileOwnerUserId);

        void OpenProfileByUsername(string profileOwnerUsername);
    }
}
