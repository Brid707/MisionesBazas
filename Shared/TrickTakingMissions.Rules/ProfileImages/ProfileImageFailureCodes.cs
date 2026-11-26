namespace ProfileImages
{
    /// <summary>Names stable profile image failures shared by the application and transport adapters.</summary>
    public static class ProfileImageFailureCodes
    {
        public const string OperationFailed = "OperationFailed";
        public const string AuthenticationRequired = "AuthenticationRequired";
        public const string ImageServiceBusy = "ImageServiceBusy";
        public const string InvalidImageRequest = "InvalidImageRequest";
        public const string ImageSizeExceeded = "ImageSizeExceeded";
        public const string InvalidImageFormat = "InvalidImageFormat";
        public const string ImageDimensionsExceeded = "ImageDimensionsExceeded";
        public const string ImageNotFound = "ImageNotFound";
        public const string InvalidStoredImage = "InvalidStoredImage";
        public const string ImageStorageUnavailable = "ImageStorageUnavailable";
        public const string ImageConnectionUnavailable = "ImageConnectionUnavailable";
        public const string ImageFileUnavailable = "ImageFileUnavailable";
    }
}
