using System.ServiceModel;
using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>Provides authenticated access to the caller's own profile.</summary>
    [ServiceContract]
    public interface IPlayerProfileService
    {
        [OperationContract]
        [FaultContract(typeof(PlayerProfileFault))]
        PlayerProfileDetails GetOwnProfile(string accountSessionToken);

        [OperationContract]
        [FaultContract(typeof(PlayerProfileFault))]
        PublicPlayerProfileDetails GetPublicProfile(PublicPlayerProfileLookup profileLookup);

        [OperationContract]
        [FaultContract(typeof(PlayerProfileFault))]
        string UpdateOwnBiography(ProfileBiographyUpdate biographyUpdate);
    }
}
