using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Windows.Input;
using Model.GameServices;
using Model.Services;
using Model.Session;
using ViewModel.Base;
using ViewModel.Constants;
using ViewModel.Services;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Base ViewModel for the active match board, transporting players and mission settings from the lobby.
    /// </summary>
    public sealed class GameMatchViewModel : ViewModelBase, IDisposable
    {
        private const int DefaultStartingMission = 1;
        private const int DefaultTargetMissions = 50;
        private const int DefaultStartingTrick = 1;
        private const int DefaultTricksPerMission = 9;

        private readonly INavigationService _navigationService;
        private readonly ILobbySession _lobbySession;
        private readonly int _currentUserId;

        private int _currentMissionNumber;
        private int _targetMissionCount;
        private int _currentTrickNumber;
        private int _totalTricksCount;
        private LobbyPlayerItemViewModel _bottomPlayer;
        private LobbyPlayerItemViewModel _leftPlayer;
        private LobbyPlayerItemViewModel _topPlayer;
        private LobbyPlayerItemViewModel _rightPlayer;

        public GameMatchViewModel(INavigationService navigationService, ILobbySession lobbySession)
        {
            _navigationService = navigationService ?? throw new ArgumentNullException(nameof(navigationService));
            _lobbySession = lobbySession ?? throw new ArgumentNullException(nameof(lobbySession));
            _currentUserId = UserSession.Current.EnsureActiveUserId();

            _currentMissionNumber = DefaultStartingMission;
            _targetMissionCount = DefaultTargetMissions;
            _currentTrickNumber = DefaultStartingTrick;
            _totalTricksCount = DefaultTricksPerMission;

            Players = new ObservableCollection<LobbyPlayerItemViewModel>();
            HowToPlayCommand = new RelayCommand(ExecuteHowToPlay);

            LoadTransportedLobbyData();
        }

        public ObservableCollection<LobbyPlayerItemViewModel> Players { get; }

        public int CurrentMissionNumber
        {
            get => _currentMissionNumber;
            set
            {
                if (SetProperty(ref _currentMissionNumber, value))
                {
                    OnPropertyChanged(nameof(MissionProgressDisplay));
                }
            }
        }

        public int TargetMissionCount
        {
            get => _targetMissionCount;
            set
            {
                if (SetProperty(ref _targetMissionCount, value))
                {
                    OnPropertyChanged(nameof(MissionProgressDisplay));
                }
            }
        }

        public string MissionProgressDisplay => string.Format(CultureInfo.InvariantCulture, "{0}/{1}", 
            CurrentMissionNumber, TargetMissionCount);

        public int CurrentTrickNumber
        {
            get => _currentTrickNumber;
            set
            {
                if (SetProperty(ref _currentTrickNumber, value))
                {
                    OnPropertyChanged(nameof(TrickProgressDisplay));
                }
            }
        }

        public int TotalTricksCount
        {
            get => _totalTricksCount;
            set
            {
                if (SetProperty(ref _totalTricksCount, value))
                {
                    OnPropertyChanged(nameof(TrickProgressDisplay));
                }
            }
        }

        public string TrickProgressDisplay => string.Format(CultureInfo.InvariantCulture, "{0}/{1}",
            CurrentTrickNumber, TotalTricksCount);

        public LobbyPlayerItemViewModel BottomPlayer
        {
            get => _bottomPlayer;
            private set
            {
                if (SetProperty(ref _bottomPlayer, value))
                {
                    OnPropertyChanged(nameof(HasBottomPlayer));
                }
            }
        }

        public LobbyPlayerItemViewModel LeftPlayer
        {
            get => _leftPlayer;
            private set
            {
                if (SetProperty(ref _leftPlayer, value))
                {
                    OnPropertyChanged(nameof(HasLeftPlayer));
                }
            }
        }

        public LobbyPlayerItemViewModel TopPlayer
        {
            get => _topPlayer;
            private set
            {
                if (SetProperty(ref _topPlayer, value))
                {
                    OnPropertyChanged(nameof(HasTopPlayer));
                }
            }
        }

        public LobbyPlayerItemViewModel RightPlayer
        {
            get => _rightPlayer;
            private set
            {
                if (SetProperty(ref _rightPlayer, value))
                {
                    OnPropertyChanged(nameof(HasRightPlayer));
                }
            }
        }

        public bool HasBottomPlayer => BottomPlayer != null;

        public bool HasLeftPlayer => LeftPlayer != null;

        public bool HasTopPlayer => TopPlayer != null;

        public bool HasRightPlayer => RightPlayer != null;

        public ICommand HowToPlayCommand { get; }

        public MatchBoardViewModel MatchBoard { get; private set; }

        public void ConfigureMatch(IMatchClient matchClient)
        {
            MatchBoard?.Dispose();
            MatchBoard = new MatchBoardViewModel(_lobbySession.CurrentLobby.LobbyCode, _currentUserId, matchClient);
            MatchBoard.ConfigureParticipantNames(Players);
            OnPropertyChanged(nameof(MatchBoard));
            _ = MatchBoard.SynchronizeMatchAsync();
        }

        public void ConfigureProfileImages(IProfileImageCache profileImageCache)
        {
            foreach (LobbyPlayerItemViewModel player in Players)
            {
                player.AttachProfileImage(profileImageCache);
            }
        }

        public void Dispose()
        {
            MatchBoard?.Dispose();
            foreach (LobbyPlayerItemViewModel player in Players)
            {
                player.Dispose();
            }
        }

        private void LoadTransportedLobbyData()
        {
            Lobby activeLobby = _lobbySession.CurrentLobby;
            if (activeLobby != null)
            {
                TargetMissionCount = activeLobby.TargetMissionCount > 0
                    ? activeLobby.TargetMissionCount
                    : DefaultTargetMissions;

                if (activeLobby.Players != null && activeLobby.Players.Length > 0)
                {
                    AssignTableSeats(activeLobby.Players);
                }
            }
        }

        private void AssignTableSeats(IList<LobbyPlayer> lobbyPlayers)
        {
            Players.Clear();
            List<LobbyPlayerItemViewModel> orderedItems = new List<LobbyPlayerItemViewModel>();

            int localIndex = 0;
            for (int i = 0; i < lobbyPlayers.Count; i++)
            {
                if (lobbyPlayers[i] != null && lobbyPlayers[i].IdUser == _currentUserId)
                {
                    localIndex = i;
                    break;
                }
            }

            for (int offset = 0; offset < lobbyPlayers.Count; offset++)
            {
                LobbyPlayer participant = lobbyPlayers[(localIndex + offset) % lobbyPlayers.Count];
                if (participant != null)
                {
                    LobbyPlayerItemViewModel item = new LobbyPlayerItemViewModel(
                        participant.IdUser,
                        participant.Username,
                        participant.IsHost)
                    {
                        IsCurrentPlayer = participant.IdUser == _currentUserId,
                        IsReady = participant.IsReady
                    };
                    Players.Add(item);
                    orderedItems.Add(item);
                }
            }

            BottomPlayer = orderedItems.ElementAtOrDefault(0);
            LeftPlayer = orderedItems.ElementAtOrDefault(1);
            TopPlayer = orderedItems.Count == 4 ? orderedItems.ElementAtOrDefault(2) : null;
            RightPlayer = orderedItems.Count == 3
                ? orderedItems.ElementAtOrDefault(2) : orderedItems.ElementAtOrDefault(3);
        }

        private void ExecuteHowToPlay()
        {
            try
            {
                _navigationService.ShowDialog(ViewId.HowToPlayDialog);
            }
            catch (InvalidOperationException ex)
            {
                Console.WriteLine($"[GameMatchViewModel] Error opening HowToPlay dialog: {ex.Message}");
            }
        }
    }
}
