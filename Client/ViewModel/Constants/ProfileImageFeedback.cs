namespace ViewModel.Constants
{
    /// <summary>Defines presentation states for profile image selection, upload and known failures.</summary>
    public enum ProfileImageFeedback
    {
        None,
        Uploading,
        UploadSucceeded,
        AuthenticationRequired,
        ImageServiceBusy,
        InvalidImageRequest,
        ImageSizeExceeded,
        InvalidImageFormat,
        ImageDimensionsExceeded,
        ImageNotFound,
        InvalidStoredImage,
        ImageStorageUnavailable,
        ImageConnectionUnavailable,
        ImageFileUnavailable,
        OperationFailed
    }
}
