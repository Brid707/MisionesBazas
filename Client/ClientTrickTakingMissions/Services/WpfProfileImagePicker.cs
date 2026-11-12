using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.Win32;
using Model.Services;
using ProfileImages;
using ViewModel.Constants;
using ViewModel.Models;
using ViewModel.Services;

namespace View.Services
{
    /// <summary>
    /// Adapts the Windows file selector to bounded asynchronous profile image selection.
    /// </summary>
    public sealed class WpfProfileImagePicker : IProfileImagePicker
    {

        public async Task<ProfileImageSelection> PickProfileImageAsync()
        {
            var picker = new OpenFileDialog
            {
                Title = Properties.Langs.Resources.Profile_SelectImage,
                Filter = Properties.Langs.Resources.Profile_ImageFileFilter,
                InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyPictures),
                RestoreDirectory = true,
                CheckFileExists = true,
                Multiselect = false
            };
            var profileImageSelection = new ProfileImageSelection();
            if (picker.ShowDialog(System.Windows.Application.Current.MainWindow) == true)
            {
                profileImageSelection = await Task.Run(() => ReadSelectedImage(picker.FileName));
            }
            return profileImageSelection;
        }

        private static ProfileImageSelection ReadSelectedImage(string selectedImagePath)
        {
            var profileImageSelection = new ProfileImageSelection();
            try
            {
                using (var imageStream = new FileStream(selectedImagePath, FileMode.Open,
                    FileAccess.Read, FileShare.Read))
                using (var reader = new BinaryReader(imageStream))
                {
                    ProfileImageFeedback selectionFeedback = GetSelectionFeedback(imageStream.Length);
                    if (selectionFeedback == ProfileImageFeedback.None)
                    {
                        byte[] selectedProfileImageBytes = reader.ReadBytes(ProfileImageLimits.MaximumUploadBytes + 1);
                        selectionFeedback = GetSelectionFeedback(selectedProfileImageBytes.Length);
                        if (selectionFeedback == ProfileImageFeedback.None)
                        {
                            profileImageSelection.SelectedProfileImageBytes = selectedProfileImageBytes;
                        }
                    }
                    profileImageSelection.SelectionFeedback = selectionFeedback;
                }
            }
            catch (IOException ex)
            {
                throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageFileUnavailable, ex);
            }
            catch (UnauthorizedAccessException ex)
            {
                throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageFileUnavailable, ex);
            }
            return profileImageSelection;
        }

        private static ProfileImageFeedback GetSelectionFeedback(long selectedImageLength)
        {
            ProfileImageFeedback selectionFeedback = ProfileImageFeedback.None;
            if (selectedImageLength == 0)
            {
                selectionFeedback = ProfileImageFeedback.InvalidImageFormat;
            }
            else if (selectedImageLength > ProfileImageLimits.MaximumUploadBytes)
            {
                selectionFeedback = ProfileImageFeedback.ImageSizeExceeded;
            }
            return selectionFeedback;
        }
    }
}
