using System.Threading.Tasks;
using ViewModel.Models;

namespace ViewModel.Services
{
    /// <summary>
    /// Selects a local profile image without exposing a Windows dialog to the ViewModel.
    /// </summary>
    public interface IProfileImagePicker
    {
        Task<ProfileImageSelection> PickProfileImageAsync();
    }
}
