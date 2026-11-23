using System.ServiceModel;

namespace PlayerProfiles
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
        string UpdateOwnBiography(ProfileBiographyUpdate biographyUpdate);
    }
}
