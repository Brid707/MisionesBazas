using System;
using System.Collections.ObjectModel;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Input;
using Model.GameServices;
using Model.Services;
using Model.Session;
using TrickTakingMissions.Logging.Abstractions.Ports;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Coordinates lobby chat input, confirmed messages, retry identity and private moderation feedback.
    /// </summary>
    public sealed class LobbyChatViewModel : ViewModelBase, IDisposable
    {
        private const int MaximumVisibleChatMessages = 100;
        private const string LogChatDeliveryUnknown =
            "Lobby chat submission returned null outcome for LobbyCode={LobbyCode}.";
        private const string LogChatModerationUnavailable =
            "Lobby chat moderation unavailable for LobbyCode={LobbyCode}.";
        private const string LogAccountBanApplied = "Chat account ban applied ({BanType}) in LobbyCode={LobbyCode}.";

        private readonly ILobbySession _lobbySession;
        private readonly ILobbyClient _chatLobbyClient;
        private readonly INavigationService _navigationService;
        private readonly ILoggerService _logger;
        private readonly IChatModerationPresenter _chatModerationPresenter;
        private readonly SynchronizationContext _chatUiSynchronizationContext;
        private readonly string _chatLobbyCode;
        private string _draftChatMessageText;
        private LobbyChatMessageSubmission _pendingChatMessageSubmission;
        private LobbyChatMessageSubmissionOutcome _chatSubmissionFeedback;
        private bool _isChatSendingAvailable;
        private long _chatAvailabilityStateVersion;
        private bool _hasAppliedAccountBan;
        private bool _isChatDisposed;
        private IProfileImageCache _profileImageCache;

        public LobbyChatViewModel(ViewModelNavigationLogging navigationLogging, ILobbySession lobbySession,
            IChatModerationPresenter chatModerationPresenter)
        {
            if (navigationLogging == null)
            {
                throw new ArgumentNullException(nameof(navigationLogging));
            }

            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _chatLobbyClient = lobbySession.Client;
            _navigationService = navigationLogging.NavigationService;
            _logger = navigationLogging.Logger;
            _chatModerationPresenter = chatModerationPresenter;
            _chatUiSynchronizationContext = SynchronizationContext.Current;
            _chatLobbyCode = lobbySession.CurrentLobby?.LobbyCode ?? string.Empty;
            _isChatSendingAvailable = lobbySession.CurrentLobby?.IsChatSendingAvailable == true;
            _chatAvailabilityStateVersion = lobbySession.CurrentLobby?.StateVersion ?? 0;
            _draftChatMessageText = string.Empty;
            if (!_isChatSendingAvailable)
            {
                ShowChatUnavailableFeedback();
            }
            ChatMessages = new ObservableCollection<LobbyChatMessageViewModel>();
            SendChatMessageCommand = new AsyncRelayCommand(SendChatMessageAsync, CanSendChatMessage);
            _chatLobbyClient.LobbyStateChanged += OnChatLobbyStateChanged;
            _chatLobbyClient.ChatMessageReceived += OnLobbyChatMessageReceived;
            _chatLobbyClient.ChatAccountBanApplied += OnChatAccountBanApplied;
        }

        public ObservableCollection<LobbyChatMessageViewModel> ChatMessages { get; }

        public string DraftChatMessageText
        {
            get => _draftChatMessageText;
            set
            {
                SetProperty(ref _draftChatMessageText, value);
                CommandManager.InvalidateRequerySuggested();
            }
        }

        public bool IsRegisteredAccountChatAvailable =>
            _isChatSendingAvailable &&
            !string.IsNullOrEmpty(UserSession.Current.CurrentUser?.AccountSessionToken) && !_hasAppliedAccountBan;

        public LobbyChatMessageSubmissionOutcome ChatSubmissionFeedback
        {
            get => _chatSubmissionFeedback;
            private set
            {
                if (SetProperty(ref _chatSubmissionFeedback, value))
                {
                    OnPropertyChanged(nameof(ChatSubmissionFeedbackText));
                }
            }
        }

        public string ChatSubmissionFeedbackText =>
            _chatModerationPresenter.FormatChatSubmissionFeedback(ChatSubmissionFeedback);

        public ICommand SendChatMessageCommand { get; }

        public void ConfigureProfileImages(IProfileImageCache profileImageCache)
        {
            _profileImageCache = profileImageCache;
            foreach (LobbyChatMessageViewModel chatMessage in ChatMessages)
            {
                chatMessage.AttachProfileImage(profileImageCache);
            }
        }

        public void Dispose()
        {
            _isChatDisposed = true;
            foreach (LobbyChatMessageViewModel chatMessage in ChatMessages)
            {
                chatMessage.Dispose();
            }
            _chatLobbyClient.LobbyStateChanged -= OnChatLobbyStateChanged;
            _chatLobbyClient.ChatMessageReceived -= OnLobbyChatMessageReceived;
            _chatLobbyClient.ChatAccountBanApplied -= OnChatAccountBanApplied;
        }

        private bool CanSendChatMessage()
        {
            return !_isChatDisposed && IsRegisteredAccountChatAvailable &&
                !string.IsNullOrWhiteSpace(DraftChatMessageText);
        }

        private async Task SendChatMessageAsync()
        {
            PreparePendingChatSubmission();
            LobbyChatMessageSubmission submittedChatMessage = _pendingChatMessageSubmission;
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome =
                await _chatLobbyClient.SendLobbyChatMessageAsync(
                submittedChatMessage);
            if (!_isChatDisposed && !_hasAppliedAccountBan)
            {
                ProcessSubmissionFeedback(submittedChatMessage, chatMessageSubmissionOutcome);
            }
        }

        private void PreparePendingChatSubmission()
        {
            if (_pendingChatMessageSubmission == null ||
                _pendingChatMessageSubmission.OriginalChatMessageText != DraftChatMessageText)
            {
                _pendingChatMessageSubmission = new LobbyChatMessageSubmission
                {
                    ChatMessageSubmissionId = Guid.NewGuid(),
                    LobbyCode = _chatLobbyCode,
                    OriginalChatMessageText = DraftChatMessageText
                };
            }
        }

        private void ProcessSubmissionFeedback(LobbyChatMessageSubmission submittedChatMessage,
            LobbyChatMessageSubmissionOutcome chatMessageSubmissionOutcome)
        {
            if (chatMessageSubmissionOutcome == null)
            {
                _logger.Warning(LogChatDeliveryUnknown, _chatLobbyCode);
                ChatSubmissionFeedback = new LobbyChatMessageSubmissionOutcome
                {
                    ChatMessageRejectionReason = ChatMessageRejectionReason.ChatDeliveryUnknown
                };
            }
            else
            {
                ChatSubmissionFeedback = chatMessageSubmissionOutcome;
                if (chatMessageSubmissionOutcome.ChatAccountBanNotice != null)
                {
                    ApplyAccountBan(chatMessageSubmissionOutcome.ChatAccountBanNotice);
                }
                else if (chatMessageSubmissionOutcome.IsChatMessageAccepted)
                {
                    ClearAcceptedDraft(submittedChatMessage);
                }
            }
        }

        private void ClearAcceptedDraft(LobbyChatMessageSubmission submittedChatMessage)
        {
            _pendingChatMessageSubmission = null;
            if (DraftChatMessageText == submittedChatMessage.OriginalChatMessageText)
            {
                DraftChatMessageText = string.Empty;
            }
        }

        private void OnChatLobbyStateChanged(object sender, LobbyStateChangedEventArgs e)
        {
            DispatchChatUiAction(() => ApplyChatAvailability(e.ConfirmedLobby));
        }

        private void ApplyChatAvailability(Lobby confirmedLobby)
        {
            if (!_isChatDisposed && confirmedLobby?.LobbyCode == _chatLobbyCode &&
                confirmedLobby.StateVersion >= _chatAvailabilityStateVersion)
            {
                _chatAvailabilityStateVersion = confirmedLobby.StateVersion;
                _isChatSendingAvailable = confirmedLobby.IsChatSendingAvailable;
                OnPropertyChanged(nameof(IsRegisteredAccountChatAvailable));
                CommandManager.InvalidateRequerySuggested();
                if (!_isChatSendingAvailable)
                {
                    ShowChatUnavailableFeedback();
                }
                else if (ChatSubmissionFeedback?.ChatMessageRejectionReason ==
                    ChatMessageRejectionReason.ChatModerationUnavailable)
                {
                    ChatSubmissionFeedback = null;
                }
            }
        }

        private void ShowChatUnavailableFeedback()
        {
            _logger.Warning(LogChatModerationUnavailable, _chatLobbyCode);
            ChatSubmissionFeedback = new LobbyChatMessageSubmissionOutcome
            {
                ChatMessageRejectionReason = ChatMessageRejectionReason.ChatModerationUnavailable
            };
        }

        private void OnLobbyChatMessageReceived(LobbyMessage publishedChatMessage)
        {
            DispatchChatUiAction(() => AppendPublishedChatMessage(publishedChatMessage));
        }

        private void AppendPublishedChatMessage(LobbyMessage publishedChatMessage)
        {
            if (!_isChatDisposed)
            {
                var chatMessage = new LobbyChatMessageViewModel(publishedChatMessage);
                if (_profileImageCache != null)
                {
                    chatMessage.AttachProfileImage(_profileImageCache);
                }
                ChatMessages.Add(chatMessage);
                if (ChatMessages.Count > MaximumVisibleChatMessages)
                {
                    ChatMessages[0].Dispose();
                    ChatMessages.RemoveAt(0);
                }
            }
        }

        private void OnChatAccountBanApplied(object sender, ChatAccountBanAppliedEventArgs e)
        {
            DispatchChatUiAction(() => ApplyAccountBan(e.ChatAccountBanNotice));
        }

        private void ApplyAccountBan(ChatAccountBanNotice chatAccountBanNotice)
        {
            if (!_hasAppliedAccountBan && !_isChatDisposed)
            {
                _logger.Warning(LogAccountBanApplied, chatAccountBanNotice?.ChatAccountBanType, _chatLobbyCode);
                _hasAppliedAccountBan = true;
                _lobbySession.ClearLobby();
                UserSession.Current.ClearSession();
                _navigationService.NavigateTo(ViewId.HomeScreen);
                _chatModerationPresenter.ShowChatAccountBan(chatAccountBanNotice);
            }
        }

        private void DispatchChatUiAction(Action chatUiAction)
        {
            if (_chatUiSynchronizationContext != null &&
                SynchronizationContext.Current != _chatUiSynchronizationContext)
            {
                _chatUiSynchronizationContext.Post(_ => chatUiAction(), null);
            }
            else
            {
                chatUiAction();
            }
        }
    }
}
