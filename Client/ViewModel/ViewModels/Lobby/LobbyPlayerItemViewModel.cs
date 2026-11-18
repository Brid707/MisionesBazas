using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;
using Model.Services;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    /// <summary>
    /// Presentation model representing a single participant slot inside the game lobby view.
    /// </summary>
    public sealed class LobbyPlayerItemViewModel : ViewModelBase, IDisposable
    {
        private const int MaximumVisibleHandCardCount = 14;
        private bool _isReady;
        private bool _isMissionCaptain;
        private int _remainingHandCardCount;
        private int _wonTrickCount;

        public LobbyPlayerItemViewModel(int idUser, string username, bool isHost)
        {
            IdUser = idUser;
            Username = username ?? string.Empty;
            IsHost = isHost;
            WonCardIds = new ObservableCollection<int>();
        }

        public IEnumerable<int> HiddenCardSlots => Enumerable.Range(0, _remainingHandCardCount);

        public ObservableCollection<MissionObjectiveViewModel> MissionObjectives { get; } =
            new ObservableCollection<MissionObjectiveViewModel>();

        public ObservableCollection<int> WonCardIds { get; }

        public ProfileImageViewModel ProfileImage { get; private set; }

        public int IdUser { get; }

        public string Username { get; }

        public bool IsHost { get; }

        public bool IsCurrentPlayer { get; set; }

        /// <summary>
        /// Indicates whether this row offers host participant actions.
        /// </summary>
        public bool CanBeKickedByCurrentHost { get; set; }

        /// <summary>
        /// Requests removal of this participant after checking the current host permission.
        /// </summary>
        public ICommand KickPlayerCommand { get; set; }

        public bool IsOtherPlayer => !IsCurrentPlayer;

        public bool IsReady
        {
            get => _isReady;
            set => SetProperty(ref _isReady, value);
        }

        public bool IsMissionCaptain
        {
            get => _isMissionCaptain;
            private set => SetProperty(ref _isMissionCaptain, value);
        }

        public int WonTrickCount
        {
            get => _wonTrickCount;
            private set
            {
                if (SetProperty(ref _wonTrickCount, value))
                {
                    OnPropertyChanged(nameof(HasWonTricks));
                }
            }
        }

        public bool HasWonTricks => WonTrickCount > 0;

        public void UpdateRemainingHandCardCount(int remainingHandCardCount)
        {
            _remainingHandCardCount = Math.Max(0, Math.Min(MaximumVisibleHandCardCount, remainingHandCardCount));
            OnPropertyChanged(nameof(HiddenCardSlots));
        }

        public void UpdateMissionCaptain(bool isMissionCaptain)
        {
            IsMissionCaptain = isMissionCaptain;
        }

        public void UpdateCapturedCards(int wonTrickCount, IReadOnlyList<int> wonCardIds)
        {
            WonTrickCount = Math.Max(0, wonTrickCount);
            IReadOnlyList<int> confirmedWonCardIds = wonCardIds ?? new int[0];

            if (!WonCardIds.SequenceEqual(confirmedWonCardIds))
            {
                WonCardIds.Clear();
                foreach (int wonCardId in confirmedWonCardIds)
                {
                    WonCardIds.Add(wonCardId);
                }
            }
        }

        public void AttachProfileImage(IProfileImageCache profileImageCache)
        {
            ProfileImage?.Dispose();
            ProfileImage = new ProfileImageViewModel(IdUser, profileImageCache);
            OnPropertyChanged(nameof(ProfileImage));
        }

        public void Dispose()
        {
            ProfileImage?.Dispose();
        }

    }
}
