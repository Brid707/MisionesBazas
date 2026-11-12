using System.ServiceModel;

namespace Services.Contracts
{
    /// <summary>
    /// Notifies clients that a displayed player image reference must be refreshed.
    /// </summary>
    public interface IProfileImageCallback
    {
        [OperationContract(IsOneWay = true)]
        void OnPlayerProfileImageChanged(int profileOwnerUserId);
    }
}
