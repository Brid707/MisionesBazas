using System.Runtime.Serialization;


namespace Services.DataContracts
{
    /// <summary>Identifies the duration category of an account ban caused by chat infractions.</summary>
    [DataContract]
    public enum ChatAccountBanType
    {
        [EnumMember]
        Unspecified = 0,
        [EnumMember]
        Temporary = 1,
        [EnumMember]
        Permanent = 2
    }
}
