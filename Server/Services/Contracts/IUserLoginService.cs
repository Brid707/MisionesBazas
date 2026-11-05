using System.ServiceModel;
using Services.DataContracts;

namespace Services.Contracts
{
    /// <summary>
    /// Service contract defining user authentication and login operations.
    /// </summary>
    [ServiceContract(Name = "IUserLogin", CallbackContract = typeof(IUserLoginCallback))]
    public interface IUserLoginService
    {
        /// <summary>
        /// Initiates a user login attempt asynchronously with the provided credentials.
        /// </summary>
        /// <param name="email">The email address of the user attempting to log in.</param>
        /// <param name="password">The hashed password of the user.</param>
        [OperationContract(IsOneWay = true)]
        void Login(string email, string password);
    }

    /// <summary>
    /// Callback contract defining duplex response operations for user authentication.
    /// </summary>
    public interface IUserLoginCallback
    {
        /// <summary>
        /// Notifies the client of the outcome of a login attempt.
        /// </summary>
        /// <param name="success">Indicates whether the authentication attempt succeeded.</param>
        /// <param name="message">A descriptive response message regarding the login result.</param>
        /// <param name="user">The authenticated user data transfer object if successful; otherwise, null.</param>
        [OperationContract]
        void LoginResult(bool success, string message, User user);
    }
}
