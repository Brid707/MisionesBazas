using System;

namespace Model.Services
{
    internal sealed class ProfileImageCacheEntry
    {
        internal int ReferenceCount { get; set; }
        internal Guid ProfileImageId { get; set; }
        internal byte[] ImageBytes { get; set; }
        internal DateTime LastValidatedAtUtc { get; set; }
    }
}
