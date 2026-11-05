using System.ServiceModel;
using System;

using Model.GameServices;

namespace Model.Services
{
    /// <summary>
    /// Specifies the categorization of communication or connection errors encountered during authentication.
    /// </summary>
    public enum AuthenticationErrorType
    {
        /// <summary>
        /// Indicates that the remote server endpoint could not be found or reached.
        /// </summary>
        ConnectionFailed,

        /// <summary>
        /// Indicates that the authentication request timed out waiting for a server response.
        /// </summary>
        Timeout,

        /// <summary>
        /// Indicates that a general communication fault occurred while contacting the server.
        /// </summary>
        CommunicationError
    }

    /// <summary>
    /// Manages client-side WCF communication and handles duplex authentication callbacks.
    /// </summary>
    public sealed class AuthenticationClient : IUserLoginCallback, IDisposable
    {
        private UserLoginClient _client;

        /// <summary>
        /// Initializes a new instance of the <see cref="AuthenticationClient"/> class.
        /// </summary>
        public AuthenticationClient()
        {
            InitializeClient();
        }

        /// <summary>
        /// Occurs when an authentication request completes on the server.
        /// </summary>
        public event Action<bool, string, User> LoginCompleted;

        /// <summary>
        /// Occurs when a network or communication fault prevents completing the request.
        /// </summary>
        public event Action<AuthenticationErrorType> ConnectionErrorOccurred;

        /// <summary>
        /// Sends an asynchronous user login request to the authentication service.
        /// </summary>
        /// <param name="emailOrUsername">The email or username of the account to authenticate.</param>
        /// <param name="passwordHash">The SHA-256 hash of the password.</param>
        /// <returns>True if the request was successfully dispatched to the server; otherwise, false.</returns>
        public bool SendLoginRequest(string emailOrUsername, string passwordHash)
        {
            bool isRequestSent = false;

            try
            {
                EnsureClientIsOpen();
                _client.Login(emailOrUsername, passwordHash);
                isRequestSent = true;
            }
            catch (EndpointNotFoundException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.ConnectionFailed);
            }
            catch (TimeoutException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.Timeout);
            }
            catch (CommunicationException)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                ConnectionErrorOccurred?.Invoke(AuthenticationErrorType.CommunicationError);
            }

            return isRequestSent;
        }

        /// <summary>
        /// Callback method invoked by the server with the result of a login operation.
        /// </summary>
        /// <param name="success">Indicates whether the authentication attempt succeeded.</param>
        /// <param name="message">A descriptive response message regarding the login result.</param>
        /// <param name="user">The authenticated user profile data, or null if login failed.</param>
        public void LoginResult(bool success, string message, User user)
        {
            LoginCompleted?.Invoke(success, message, user);
        }

        /// <summary>
        /// Releases all managed resources used by the <see cref="AuthenticationClient"/>.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void InitializeClient()
        {
            InstanceContext instanceContext = new InstanceContext(this);
            _client = new UserLoginClient(instanceContext);
        }

        private void EnsureClientIsOpen()
        {
            if (_client == null || _client.State == CommunicationState.Faulted || _client.State == CommunicationState.Closed)
            {
                InitializeClient();
            }
        }

        private void Dispose(bool disposing)
        {
            if (disposing && _client != null)
            {
                try
                {
                    if (_client.State != CommunicationState.Closed && _client.State != CommunicationState.Faulted)
                    {
                        _client.Close();
                    }
                    else
                    {
                        _client.Abort();
                    }
                }
                catch (CommunicationException)
                {
                    // TODO: Implement logging for the exception once logging infrastructure is available.
                    _client.Abort();
                }
                catch (TimeoutException)
                {
                    // TODO: Implement logging for the exception once logging infrastructure is available.
                    _client.Abort();
                }
                finally
                {
                    _client = null;
                }
            }
        }
    }
}
