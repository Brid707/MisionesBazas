using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Threading;
using System.Windows.Input;
using System;

using Model.GameServices;
using Model.Services;
using Model.Session;
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
        private readonly ILobbySession _lobbySession;
        private readonly ILobbyClient _chatLobbyClient;
        private readonly INavigationService _navigationService;
        private readonly IChatModerationPresenter _chatModerationPresenter;
        private readonly SynchronizationContext _chatUiSynchronizationContext;
        private readonly string _chatLobbyCode;
        private string _draftChatMessageText;
        private LobbyChatMessageSubmission _pendingChatMessageSubmission;
        private LobbyChatMessageSubmissionOutcome _chatSubmissionFeedback;
        private bool _hasAppliedAccountBan;
        private bool _isChatDisposed;

        public LobbyChatViewModel(ILobbySession lobbySession, INavigationService navigationService,
            IChatModerationPresenter chatModerationPresenter)
        {
            _lobbySession = lobbySession;
            _chatLobbyClient = lobbySession.Client;
            _navigationService = navigationService;
            _chatModerationPresenter = chatModerationPresenter;
            _chatUiSynchronizationContext = SynchronizationContext.Current;
            _chatLobbyCode = lobbySession.CurrentLobby?.LobbyCode ?? string.Empty;
            _draftChatMessageText = string.Empty;
            ChatMessages = new ObservableCollection<LobbyMessage>();
            SendChatMessageCommand = new AsyncRelayCommand(SendChatMessageAsync, CanSendChatMessage);
            _chatLobbyClient.ChatMessageReceived += OnLobbyChatMessageReceived;
            _chatLobbyClient.ChatAccountBanApplied += OnChatAccountBanApplied;
        }

        public ObservableCollection<LobbyMessage> ChatMessages { get; }

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

        public void Dispose()
        {
            _isChatDisposed = true;
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

        private void OnLobbyChatMessageReceived(LobbyMessage publishedChatMessage)
        {
            DispatchChatUiAction(() => AppendPublishedChatMessage(publishedChatMessage));
        }

        private void AppendPublishedChatMessage(LobbyMessage publishedChatMessage)
        {
            if (!_isChatDisposed)
            {
                ChatMessages.Add(publishedChatMessage);
                if (ChatMessages.Count > MaximumVisibleChatMessages)
                {
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
