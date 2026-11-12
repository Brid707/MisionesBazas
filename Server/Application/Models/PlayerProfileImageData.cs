using System;

namespace Application.Models
{
    /// <summary>
    /// Associates an account with its current image identifier inside the application boundary.
    /// </summary>
    public sealed class PlayerProfileImageData
    {
        public int ProfileOwnerUserId { get; set; }
        public Guid ProfileImageId { get; set; }
    }
}
