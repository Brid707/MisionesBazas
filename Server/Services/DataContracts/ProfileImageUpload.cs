using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Carries the selected image bytes without accepting an account identifier or filesystem path.
    /// </summary>
    [DataContract(Namespace = "urn:misiones-bazas:profile-images")]
    public sealed class ProfileImageUpload
    {
        [DataMember(Order = 1)]
        public byte[] SelectedProfileImageBytes { get; set; }
    }
}
