using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Identifies the current image version associated with a player.
    /// </summary>
    [DataContract(Namespace = "urn:misiones-bazas:profile-images")]
    public sealed class PlayerProfileImageReference
    {
        [DataMember(Order = 1)]
        public int ProfileOwnerUserId { get; set; }

        [DataMember(Order = 2)]
        public Guid ProfileImageId { get; set; }
    }
}
