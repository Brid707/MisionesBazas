using System;
using System.Diagnostics;
using System.ServiceModel;
using System.Threading;
using System.Windows.Input;

using Model.GameServices;
using Model.Security;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// ViewModel for handling user login logic, decoupled from WPF UI controls.
    /// Implements <see cref="IUserLoginCallback"/> to receive asynchronous authentication responses from WCF.
    /// </summary>
    public sealed class LoginViewModel : ViewModelBase, IUserLoginCallback, IDisposable
    {
        private const string LogLoginSucceeded = "Login succeeded for UserId={UserId}.";
        private const string LogLoginRejectedWithBan = "Login rejected because account is banned ({BanType}).";
        private const string LogLoginRejected = "Login rejected with WarningCode={WarningCode}.";
        private const string LogLoginConnectionFailed = "Login endpoint unreachable.";
        private const string LogLoginTimedOut = "Login request timed out.";
        private const string LogLoginCommunicationError = "Login communication error.";
        private const string LogForgotPasswordDialogError = "Error displaying forgot password dialog.";

        private readonly INavigationService _navigationService;
        private readonly IDialogService _dialogService;
        private readonly ILoggerService _logger;
        private readonly IChatModerationPresenter _chatModerationPresenter;
        private readonly SynchronizationContext _loginSynchronizationContext;
        private readonly Stopwatch _accountBanElapsedTime = new Stopwatch();
        private Timer _accountBanCountdownTimer;
        private ChatAccountBanNotice _accountBanNotice;
        private string _accountBanFeedbackText;
        private UserLoginClient _loginServiceClient;
        private bool _isLoginDisposed;

        private string _email;
        private string _password;
        private bool _isLoading;

        /// <summary>
        /// Initializes a new instance of the <see cref="LoginViewModel"/> class with the required UI services.
        /// </summary>
        /// <param name="uiServices">Grouped navigation, dialog and logging services.</param>
        /// <param name="chatModerationPresenter">Formats private account restrictions in the selected language.</param>
        public LoginViewModel(ViewModelUiServices uiServices, IChatModerationPresenter chatModerationPresenter)
        {
            if (uiServices == null)
            {
                throw new ArgumentNullException(nameof(uiServices));
            }

            _navigationService = uiServices.NavigationService;
            _dialogService = uiServices.DialogService;
            _logger = uiServices.Logger;
            _chatModerationPresenter = chatModerationPresenter;
            _loginSynchronizationContext = SynchronizationContext.Current;

            LoginCommand = new RelayCommand(ExecuteLogin, CanExecuteLogin);
            BackCommand = new RelayCommand(ExecuteBack);
            ForgotPasswordCommand = new RelayCommand(ExecuteForgotPassword);
        }

        public string AccountBanFeedbackText
        {
            get => _accountBanFeedbackText;
            private set => SetProperty(ref _accountBanFeedbackText, value);
        }

        /// <summary>
        /// Gets or sets the user email entered in the view.
        /// </summary>
        public string Email
        {
            get => _email;
            set => SetProperty(ref _email, value);
        }

        /// <summary>
        /// Gets or sets the user password.
        /// </summary>
        public string Password
        {
            get => _password;
            set => SetProperty(ref _password, value);
        }

        /// <summary>
        /// Indicates whether an authentication request is currently in progress.
        /// </summary>
        public bool IsLoading
        {
            get => _isLoading;
            set
            {
                if (SetProperty(ref _isLoading, value))
                {
                    CommandManager.InvalidateRequerySuggested();
                }
            }
        }

        /// <summary>
        /// Gets the command that initiates the authentication process.
        /// </summary>
        public ICommand LoginCommand { get; }

        /// <summary>
        /// Gets the command that navigates back to the home screen or closes the modal window.
        /// </summary>
        public ICommand BackCommand { get; }

        /// <summary>
        /// Gets the command that displays the password recovery dialog.
        /// </summary>
        public ICommand ForgotPasswordCommand { get; }

        /// <summary>
        /// Handles the authentication response dispatched by the login service callback.
        /// </summary>
        /// <param name="success">Indicates whether credentials were authenticated successfully.</param>
        /// <param name="message">The outcome message provided by the server.</param>
        /// <param name="user">The authenticated user profile, or null if login failed.</param>
        public void LoginResult(bool success, string message, User user)
        {
            IsLoading = false;

            if (success)
            {
                if (user != null)
                {
                    UserSession.Current.SetUser(new UserSessionData
                    {
                        IdUser = user.IdUser,
                        Username = user.Username,
                        Email = user.Email,
                        AccountSessionToken = user.AccountSessionToken
                    });
                    _logger.Information(LogLoginSucceeded, user.IdUser);
                }

                _navigationService.NavigateTo(ViewId.GameMenu);
            }
            else
            {
                ProcessLoginRejection(message, user?.ChatAccountBanNotice);
            }
        }

        public void Dispose()
        {
            _isLoginDisposed = true;
            _accountBanCountdownTimer?.Dispose();
            _loginServiceClient?.Abort();
        }

        private void ProcessLoginRejection(string rejectionReason, ChatAccountBanNotice accountBanNotice)
        {
            if (accountBanNotice != null)
            {
                _logger.Warning(LogLoginRejectedWithBan, accountBanNotice.ChatAccountBanType);
                _accountBanNotice = accountBanNotice;
                _accountBanElapsedTime.Restart();
                UpdateAccountBanCountdown();
                _accountBanCountdownTimer?.Dispose();
                if (accountBanNotice.ChatAccountBanType == ChatAccountBanType.Temporary)
                {
                    _accountBanCountdownTimer = new Timer(OnAccountBanCountdownTick, null,
                        TimeSpan.FromSeconds(1), TimeSpan.FromSeconds(1));
                }
            }
            else
            {
                int loginWarningCode = MessageCode.InvalidCredentials;
                if (rejectionReason == "ChatStorageUnavailable")
                {
                    loginWarningCode = MessageCode.ChatStorageUnavailable;
                }

                _logger.Warning(LogLoginRejected, loginWarningCode);
                _dialogService.ShowWarning(loginWarningCode);
            }
        }

        private void OnAccountBanCountdownTick(object countdownTimerState)
        {
            if (_loginSynchronizationContext != null)
            {
                _loginSynchronizationContext.Post(_ => UpdateAccountBanCountdown(), null);
            }
            else
            {
                UpdateAccountBanCountdown();
            }
        }

        private void UpdateAccountBanCountdown()
        {
            if (!_isLoginDisposed && _accountBanNotice != null)
            {
                AccountBanFeedbackText = _chatModerationPresenter.FormatAccountBan(new ChatAccountBanNotice
                {
                    ChatAccountBanType = _accountBanNotice.ChatAccountBanType,
                    ChatAccountBanEndsAtUtc = _accountBanNotice.ChatAccountBanEndsAtUtc,
                    EvaluatedAtUtc = _accountBanNotice.EvaluatedAtUtc + _accountBanElapsedTime.Elapsed
                });
                if (_accountBanNotice.ChatAccountBanEndsAtUtc <=
                    _accountBanNotice.EvaluatedAtUtc + _accountBanElapsedTime.Elapsed)
                {
                    _accountBanCountdownTimer?.Dispose();
                }
            }
        }

        private bool CanExecuteLogin()
        {
            return !IsLoading;
        }

        private void ExecuteLogin()
        {
            string email = Email?.Trim() ?? string.Empty;
            string password = Password ?? string.Empty;

            if (IsLoginInputValid(email, password))
            {
                try
                {
                    IsLoading = true;
                    string passwordHash = PasswordHasher.ComputeSha256Hash(password);
                    InstanceContext context = new InstanceContext(this);
                    _accountBanCountdownTimer?.Dispose();
                    AccountBanFeedbackText = string.Empty;
                    _loginServiceClient?.Abort();
                    _loginServiceClient = new UserLoginClient(context);
                    _loginServiceClient.Login(email, passwordHash);
                }
                catch (EndpointNotFoundException ex)
                {
                    IsLoading = false;
                    _logger.Error(ex, LogLoginConnectionFailed);
                    _dialogService.ShowError(MessageCode.ConnectionFailed);
                }
                catch (TimeoutException ex)
                {
                    IsLoading = false;
                    _logger.Error(ex, LogLoginTimedOut);
                    _dialogService.ShowError(MessageCode.RequestTimeout);
                }
                catch (CommunicationException ex)
                {
                    IsLoading = false;
                    _logger.Error(ex, LogLoginCommunicationError);
                    _dialogService.ShowError(MessageCode.CommunicationError);
                }
            }
        }

        private bool IsLoginInputValid(string email, string password)
        {
            bool isValid = false;

            if (string.IsNullOrWhiteSpace(email))
            {
                _dialogService.ShowWarning(MessageCode.EmptyEmail);
            }
            else if (string.IsNullOrEmpty(password))
            {
                _dialogService.ShowWarning(MessageCode.EmptyPassword);
            }
            else
            {
                isValid = true;
            }

            return isValid;
        }

        private void ExecuteBack()
        {
            _navigationService.GoBack();
        }

        private void ExecuteForgotPassword()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.ForgotPasswordDialog);
            }
            catch (InvalidOperationException ex)
            {
                _logger.Error(ex, LogForgotPasswordDialogError);
            }
        }
    }
}
