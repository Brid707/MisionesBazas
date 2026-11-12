using System;

namespace ProfileImages
{
    /// <summary>
    /// Defines the shared binary image contract budgets enforced independently by each process.
    /// </summary>
    public static class ProfileImageLimits
    {
        public const int MaximumTransportMessageBytes = 3145728;
        public const int MaximumUploadBytes = 2097152;
        public const long MaximumPixelCount = 4194304;
        public const int MaximumSourceDimension = 4096;
        public const int OutputPixelSize = 256;
        public const int MaximumStoredImageBytes = 300000;
        public const int MaximumRequestedPlayers = 64;
    }
}
