using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Carries one normalized image version to a requesting client.
    /// </summary>
    [DataContract(Namespace = "urn:misiones-bazas:profile-images")]
    public sealed class ProfileImageContent
    {
        [DataMember(Order = 1)]
        public Guid ProfileImageId { get; set; }

        [DataMember(Order = 2)]
        public byte[] NormalizedProfileImageBytes { get; set; }
    }
}
