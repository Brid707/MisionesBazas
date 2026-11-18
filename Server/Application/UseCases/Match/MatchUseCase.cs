using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Application.Ports;
using Domain;
using Gameplay;
using TrickTakingMissions.Logging.Abstractions;
using TrickTakingMissions.Logging.Abstractions.Ports;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    /// <summary>Serializes match mutations and retains decisions within their attempt scope.</summary>
    public sealed partial class MatchUseCase : IMatchUseCase
    {
        private const int MaximumProcessedSubmissions = 4096;
        private const string MatchIdentityConflictMessage = "MatchIdentityConflict";

        private const string MatchStartedTemplate =
            "Match {MatchId} started for lobby {LobbyCode} with {ParticipantCount} participants.";
        private const string MatchIdentityConflictTemplate =
            "Match identity conflict detected for lobby {LobbyCode} (Instance: {LobbyInstanceId}).";
        private const string MatchSubmissionCapacityReachedTemplate =
            "Match {MatchId} reached maximum submission capacity limit of {Limit}.";

        private readonly IMatchStateStore _matchStateStore;
        private readonly IMissionDeckDealer _missionDeckDealer;
        private readonly ILoggerService _logger;
        private readonly IMatchClock _matchClock;
        private readonly IMatchParticipantPresence _participantPresence;

        public MatchUseCase(IMatchStateStore matchStateStore, IMissionDeckDealer missionDeckDealer,
            MatchExecutionDependencies executionDependencies)
        {
            _matchStateStore = matchStateStore ?? throw new ArgumentNullException(nameof(matchStateStore));
            _missionDeckDealer = missionDeckDealer ?? throw new ArgumentNullException(nameof(missionDeckDealer));
            if (executionDependencies == null)
            {
                throw new ArgumentNullException(nameof(executionDependencies));
            }
            _logger = executionDependencies.Logger ??
                throw new ArgumentNullException(nameof(executionDependencies.Logger));
            _matchClock = executionDependencies.MatchClock ??
                throw new ArgumentNullException(nameof(executionDependencies.MatchClock));
            _participantPresence = executionDependencies.ParticipantPresence ??
                throw new ArgumentNullException(nameof(executionDependencies.ParticipantPresence));
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
                _logger.Warning(MatchIdentityConflictTemplate, lobbyCode, lobbyInstanceId);
                throw new InvalidOperationException(MatchIdentityConflictMessage);
            }

            _logger.Information(MatchStartedTemplate, matchState.MatchId, lobbyCode, participantUserIds.Length);
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
                        playerSnapshot = MatchSnapshotProjection.CreateSnapshot(matchState, participantSeat,
                            _matchClock.GetTimestampMilliseconds());
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
            var matchState = new MatchState
            {
                LobbyInstanceId = lobbyInstanceId,
                ParticipantUserIds = (int[])participantUserIds.Clone()
            };
            PreparedMissionAttempt preparedAttempt = MissionAttemptPreparation.Prepare(
                new MissionAttemptPreparationContext
                {
                    MissionNumber = MissionCatalog.MinimumMissionNumber,
                    MissionAttemptId = MissionAttemptPreparation.InitialMissionAttemptId,
                    AttemptNumber = Domain.MissionProgressionRules.InitialAttemptNumber,
                    ParticipantUserIds = matchState.ParticipantUserIds
                }, _missionDeckDealer);
            matchState.InitializePreparedMissionAttempt(preparedAttempt);
            return matchState;
        }

        private CardPlayDecision ProcessPlayUnderLock(MatchState matchState,
            CardPlaySubmission cardPlaySubmission, int participantUserId)
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
            else if (cardPlaySubmission.MissionAttemptId != matchState.MissionAttempt.MissionAttemptId)
            {
                playDecision.RejectionReason = MatchRejectionReason.WrongMissionAttempt;
            }
            else
            {
                playDecision = ProcessIdentifiedPlay(matchState, cardPlaySubmission, participantSeat);
            }
            return playDecision;
        }

        private CardPlayDecision ProcessIdentifiedPlay(MatchState matchState,
            CardPlaySubmission cardPlaySubmission, int participantSeat)
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
                processedPlay.ExpectedMatchStateVersion == cardPlaySubmission.ExpectedMatchStateVersion &&
                processedPlay.MissionAttemptId == cardPlaySubmission.MissionAttemptId;
            return isSameSubmission ? MatchSnapshotProjection.CloneDecision(processedPlay.Decision) :
                new CardPlayDecision
                {
                    CardPlaySubmissionId = cardPlaySubmission.CardPlaySubmissionId,
                    RejectionReason = MatchRejectionReason.SubmissionIdentityReused
                };
        }

        private CardPlayDecision ProcessNewPlay(MatchState matchState, CardPlaySubmission cardPlaySubmission,
            int participantSeat)
        {
            var playDecision = new CardPlayDecision { CardPlaySubmissionId = cardPlaySubmission.CardPlaySubmissionId };
            if (matchState.ProcessedCardPlayDecisionsBySubmissionId.Count >= MaximumProcessedSubmissions)
            {
                _logger.Warning(MatchSubmissionCapacityReachedTemplate, matchState.MatchId, MaximumProcessedSubmissions);
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
                        MissionAttemptId = cardPlaySubmission.MissionAttemptId,
                        ExpectedMatchStateVersion = cardPlaySubmission.ExpectedMatchStateVersion,
                        Decision = MatchSnapshotProjection.CloneDecision(playDecision)
                    });
            }
            return playDecision;
        }

        private static void ApplyAcceptedPlay(MatchState matchState, int playedCardId, int participantSeat)
        {
            var acceptedPlay = new MatchCardPlay
            {
                PlayerUserId = matchState.ParticipantUserIds[participantSeat],
                CardId = playedCardId
            };
            MatchCardPlay[] candidateTrickPlays = matchState.CurrentTrickCardPlays.Concat(new[] { acceptedPlay })
                .ToArray();
            CompletedTrickResolution completedTrick = null;
            if (candidateTrickPlays.Length == matchState.ParticipantUserIds.Length)
            {
                completedTrick = PrepareCompletedTrick(matchState, candidateTrickPlays);
            }
            matchState.PlayerHandCardIdsBySeat[participantSeat].Remove(playedCardId);
            if (completedTrick != null)
            {
                matchState.CommitCompletedTrick(completedTrick);
            }
            else
            {
                matchState.CurrentTrickCardPlays.Add(acceptedPlay);
                matchState.CurrentTurnPlayerSeat = TrickTurnRules.GetNextTurnSeat((byte)participantSeat,
                    matchState.ParticipantUserIds.Length);
            }
            matchState.MatchStateVersion++;
        }
    }
}
