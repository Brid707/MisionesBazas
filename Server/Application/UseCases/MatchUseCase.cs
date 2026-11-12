using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Application.Ports;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    /// <summary>Serializes match mutations and retains stable decisions for their in-memory lifetime.</summary>
    public sealed class MatchUseCase : IMatchUseCase
    {
        private const int MaximumProcessedSubmissions = 4096;
        private readonly IMatchStateStore _matchStateStore;
        private readonly IMissionDeckDealer _missionDeckDealer;

        public MatchUseCase(IMatchStateStore matchStateStore, IMissionDeckDealer missionDeckDealer)
        {
            _matchStateStore = matchStateStore ?? throw new ArgumentNullException(nameof(matchStateStore));
            _missionDeckDealer = missionDeckDealer ?? throw new ArgumentNullException(nameof(missionDeckDealer));
        }

        public Guid StartMatch(string lobbyCode, int[] participantUserIds, Guid lobbyInstanceId = default(Guid))
        {
            if (participantUserIds == null || participantUserIds.Length < 3 || participantUserIds.Length > 4 ||
                participantUserIds.Any(participantId => participantId == 0) ||
                participantUserIds.Distinct().Count() != participantUserIds.Length)
            {
                throw new ArgumentException(nameof(participantUserIds));
            }
            MatchState matchState = _matchStateStore.GetOrCreateMatch(lobbyCode,
                () => CreateMatchState(participantUserIds, lobbyInstanceId));
            if (matchState.LobbyInstanceId != lobbyInstanceId ||
                !matchState.ParticipantUserIds.SequenceEqual(participantUserIds))
            {
                throw new InvalidOperationException("MatchIdentityConflict");
            }
            return matchState.MatchId;
        }

        public PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId)
        {
            PlayerMatchSnapshot playerSnapshot = null;
            MatchState matchState = _matchStateStore.FindMatch(lobbyCode);
            if (matchState != null)
            {
                lock (matchState)
                {
                    int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
                    if (participantSeat >= 0)
                    {
                        playerSnapshot = MatchSnapshotProjection.CreateSnapshot(matchState, participantSeat);
                    }
                }
            }
            return playerSnapshot;
        }

        public CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            var playDecision = new CardPlayDecision
            {
                CardPlaySubmissionId = cardPlaySubmission?.CardPlaySubmissionId ?? Guid.Empty,
                RejectionReason = MatchRejectionReason.MatchUnavailable
            };
            if (cardPlaySubmission != null && !string.IsNullOrWhiteSpace(cardPlaySubmission.LobbyCode))
            {
                MatchState matchState = _matchStateStore.FindMatch(cardPlaySubmission.LobbyCode);
                if (matchState != null)
                {
                    lock (matchState)
                    {
                        playDecision = ProcessPlayUnderLock(matchState, cardPlaySubmission, participantUserId);
                    }
                }
            }
            return playDecision;
        }

        private MatchState CreateMatchState(int[] participantUserIds, Guid lobbyInstanceId)
        {
            MissionDeal missionDeal = _missionDeckDealer.CreateMissionDeal(participantUserIds.Length);
            return new MatchState
            {
                LobbyInstanceId = lobbyInstanceId,
                ParticipantUserIds = (int[])participantUserIds.Clone(),
                PlayerHandCardIdsBySeat = missionDeal.HandsBySeat
                    .Select(hand => hand.Select(card => card.IdCard).ToList()).ToArray(),
                CurrentTurnPlayerSeat = missionDeal.CaptainSeat,
                MissionCaptainSeat = missionDeal.CaptainSeat,
                MaximumMissionTrickCount = missionDeal.TotalTricksInMission
            };
        }

        private static CardPlayDecision ProcessPlayUnderLock(MatchState matchState,
            CardPlaySubmission cardPlaySubmission,
            int participantUserId)
        {
            int participantSeat = Array.IndexOf(matchState.ParticipantUserIds, participantUserId);
            var playDecision = new CardPlayDecision
            {
                CardPlaySubmissionId = cardPlaySubmission.CardPlaySubmissionId,
                CommittedMatchStateVersion = matchState.MatchStateVersion
            };
            if (participantSeat < 0)
            {
                playDecision.RejectionReason = MatchRejectionReason.ParticipantNotAllowed;
            }
            else if (cardPlaySubmission.MatchId != matchState.MatchId ||
                cardPlaySubmission.CardPlaySubmissionId == Guid.Empty)
            {
                playDecision.RejectionReason = MatchRejectionReason.InvalidSubmission;
            }
            else
            {
                playDecision = ProcessIdentifiedPlay(matchState, cardPlaySubmission, participantSeat);
            }
            return playDecision;
        }

        private static CardPlayDecision ProcessIdentifiedPlay(MatchState matchState,
            CardPlaySubmission cardPlaySubmission,
            int participantSeat)
        {
            CardPlayDecision playDecision;
            if (matchState.ProcessedCardPlayDecisionsBySubmissionId.TryGetValue(cardPlaySubmission.CardPlaySubmissionId,
                out ProcessedCardPlay processedPlay))
            {
                playDecision = ResolveRepeatedPlay(processedPlay, cardPlaySubmission,
                    matchState.ParticipantUserIds[participantSeat]);
            }
            else
            {
                playDecision = ProcessNewPlay(matchState, cardPlaySubmission, participantSeat);
            }
            return playDecision;
        }

        private static CardPlayDecision ResolveRepeatedPlay(ProcessedCardPlay processedPlay,
            CardPlaySubmission cardPlaySubmission, int participantUserId)
        {
            bool isSameSubmission = processedPlay.ParticipantUserId == participantUserId &&
                processedPlay.CardId == cardPlaySubmission.CardId &&
                processedPlay.ExpectedMatchStateVersion == cardPlaySubmission.ExpectedMatchStateVersion;
            return isSameSubmission ? MatchSnapshotProjection.CloneDecision(processedPlay.Decision) :
                new CardPlayDecision
                {
                    CardPlaySubmissionId = cardPlaySubmission.CardPlaySubmissionId,
                    RejectionReason = MatchRejectionReason.SubmissionIdentityReused
                };
        }

        private static CardPlayDecision ProcessNewPlay(MatchState matchState, CardPlaySubmission cardPlaySubmission,
            int participantSeat)
        {
            var playDecision = new CardPlayDecision { CardPlaySubmissionId = cardPlaySubmission.CardPlaySubmissionId };
            if (matchState.ProcessedCardPlayDecisionsBySubmissionId.Count >= MaximumProcessedSubmissions)
            {
                playDecision.RejectionReason = MatchRejectionReason.SubmissionCapacityReached;
            }
            else
            {
                playDecision.RejectionReason = MatchPlayValidation.GetRejection(
                    matchState, cardPlaySubmission, participantSeat);
                if (playDecision.RejectionReason == MatchRejectionReason.None)
                {
                    ApplyAcceptedPlay(matchState, cardPlaySubmission.CardId, participantSeat);
                    playDecision.IsAccepted = true;
                }
                playDecision.CommittedMatchStateVersion = matchState.MatchStateVersion;
                matchState.ProcessedCardPlayDecisionsBySubmissionId.Add(cardPlaySubmission.CardPlaySubmissionId,
                    new ProcessedCardPlay
                    {
                        ParticipantUserId = matchState.ParticipantUserIds[participantSeat],
                        CardId = cardPlaySubmission.CardId,
                        ExpectedMatchStateVersion = cardPlaySubmission.ExpectedMatchStateVersion,
                        Decision = MatchSnapshotProjection.CloneDecision(playDecision)
                    });
            }
            return playDecision;
        }

        private static void ApplyAcceptedPlay(MatchState matchState, int playedCardId, int participantSeat)
        {
            matchState.PlayerHandCardIdsBySeat[participantSeat].Remove(playedCardId);
            matchState.CurrentTrickCardPlays.Add(new MatchCardPlay
            {
                PlayerUserId = matchState.ParticipantUserIds[participantSeat], CardId = playedCardId
            });
            if (matchState.CurrentTrickCardPlays.Count == matchState.ParticipantUserIds.Length)
            {
                CompleteTrick(matchState);
            }
            else
            {
                matchState.CurrentTurnPlayerSeat = TrickTurnRules.GetNextTurnSeat((byte)participantSeat,
                    matchState.ParticipantUserIds.Length);
            }
            matchState.MatchStateVersion++;
        }

        private static void CompleteTrick(MatchState matchState)
        {
            TrickCardPlay[] trickPlays = matchState.CurrentTrickCardPlays.Select((play, playOrder) => new TrickCardPlay
            {
                PlayOrder = (byte)playOrder,
                Seat = (byte)Array.IndexOf(matchState.ParticipantUserIds, play.PlayerUserId),
                Card = DeckRules.GetCardById(play.CardId)
            }).ToArray();
            matchState.CurrentTurnPlayerSeat = TrickTurnRules.GetNextTrickLeaderSeat(trickPlays,
                matchState.ParticipantUserIds.Length);
            matchState.LastTrickWinnerUserId = matchState.ParticipantUserIds[matchState.CurrentTurnPlayerSeat];
            matchState.LastCompletedTrickCardPlays = matchState.CurrentTrickCardPlays.ToArray();
            matchState.CapturedCardPlays.AddRange(matchState.CurrentTrickCardPlays);
            matchState.CurrentTrickCardPlays.Clear();
            matchState.IsDealCompleted = matchState.CurrentTrickNumber == matchState.MaximumMissionTrickCount;
            if (!matchState.IsDealCompleted)
            {
                matchState.CurrentTrickNumber++;
            }
        }
    }
}
