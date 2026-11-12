using System;
using System.ServiceModel;
using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>
    /// Defines upload, reference lookup, download and subscriptions for player profile images.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(IProfileImageCallback),
        Namespace = "urn:misiones-bazas:profile-images")]
    public interface IProfileImageService
    {
        [OperationContract]
        [FaultContract(typeof(ProfileImageFault))]
        PlayerProfileImageReference ChangeOwnProfileImage(ProfileImageUpload profileImageUpload);

        [OperationContract]
        [FaultContract(typeof(ProfileImageFault))]
        PlayerProfileImageReference[] GetPlayerProfileImages(int[] profileOwnerUserIds);

        [OperationContract]
        [FaultContract(typeof(ProfileImageFault))]
        ProfileImageContent GetProfileImage(Guid profileImageId);

        [OperationContract]
        [FaultContract(typeof(ProfileImageFault))]
        void SubscribeProfileImageChanges(int[] profileOwnerUserIds);
    }
}
