using System.ServiceModel;
using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>
    /// Service contract defining operations for user account creation and management.
    /// </summary>
    [ServiceContract]
    public interface IAccountManagementService
    {
        /// <summary>
        /// Registers a new user account using the provided credentials.
        /// </summary>
        /// <param name="user">The registration data transfer object.</param>
        /// <returns>An <see cref="OperationResult"/> indicating success or reason for failure.</returns>
        [OperationContract]
        OperationResult RegisterUser(UserRegister user);
    }
}
