using System;
using System.Runtime.Serialization;

namespace Services.DataContracts
{
    /// <summary>
    /// Transmits a stable failure code without revealing server exceptions or physical paths.
    /// </summary>
    [DataContract(Namespace = "urn:misiones-bazas:profile-images")]
    public sealed class ProfileImageFault
    {
        [DataMember(Order = 1)]
        public string FailureCode { get; set; }
    }
}
