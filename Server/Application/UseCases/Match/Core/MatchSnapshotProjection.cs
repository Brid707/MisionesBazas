using System;
using System.Linq;
using Application.Models;

using Domain;

namespace Application.UseCases
{
    /// <summary>Builds fresh recipient-specific arrays; server-owned hands never cross this boundary.</summary>
    internal static class MatchSnapshotProjection
    {
        internal static PlayerMatchSnapshot CreateSnapshot(MatchState matchState, int participantSeat,
            long serverTimestampMilliseconds)
        {
            MissionTransitionSnapshot transition = MatchTransitionSnapshotProjector.CreateMissionTransition(
                matchState, serverTimestampMilliseconds);
            return new PlayerMatchSnapshot
            {
                MatchId = matchState.MatchId,
                MatchStateVersion = matchState.MatchStateVersion,
                OwnHandCardIds = matchState.PlayerHandCardIdsBySeat[participantSeat].ToArray(),
                ParticipantUserIds = (int[])matchState.ParticipantUserIds.Clone(),
                RemainingHandCardCounts = matchState.PlayerHandCardIdsBySeat.Select(hand => hand.Count).ToArray(),
                CurrentTurnPlayerUserId = matchState.ParticipantUserIds[matchState.CurrentTurnPlayerSeat],
                MissionCaptainUserId = matchState.ParticipantUserIds[matchState.MissionCaptainSeat],
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                MaximumMissionTrickCount = matchState.MaximumMissionTrickCount,
                IsDealCompleted = matchState.IsDealCompleted,
                CurrentTrickCardPlays = matchState.CurrentTrickCardPlays.Select(ClonePlay).ToArray(),
                LastCompletedTrickCardPlays = matchState.LastCompletedTrickCardPlays.Select(ClonePlay).ToArray(),
                LastTrickWinnerUserId = matchState.LastTrickWinnerUserId,
                CapturedCardsByPlayer = CreateCapturedCardsSnapshots(matchState),
                MissionTransition = transition,
                RadioCommunications = MatchRadioCommunicationSnapshotProjector.CreateRadioCommunications(matchState),
                RadioMode = MatchRadioCommunicationSnapshotProjector.GetRadioMode(matchState),
                OwnRadioAvailability = MatchRadioCommunicationSnapshotProjector.CreateRadioAvailability(matchState, participantSeat),
                MissionConditionProgress = new MissionConditionProgressSnapshot
                {
                    TricksWonWithNormalOneCount = matchState.TrickStatistics.TricksWonWithNormalOneCount,
                    SpecialWinningCardIds = matchState.TrickStatistics.SpecialWinningCardIds.ToArray(),
                    CapturedHeartCardCount = MatchUseCase.CountCapturedHearts(matchState)
                },
                MissionRetry = MatchMissionRetrySnapshotProjector.CreateMissionRetry(transition),
                MissionEvaluation = MatchEvaluationSnapshotProjector.CreateMissionEvaluation(matchState),
                MissionPreparation = MatchObjectiveDraftSnapshotProjector.CreateMissionPreparation(matchState, participantSeat),
                DistressSignal = CreateDistressSignalSnapshot(matchState)
            };
        }

        internal static MatchCardPlay ClonePlay(MatchCardPlay confirmedPlay)
        {
            return new MatchCardPlay { PlayerUserId = confirmedPlay.PlayerUserId, CardId = confirmedPlay.CardId };
        }

        internal static CardPlayDecision CloneDecision(CardPlayDecision playDecision)
        {
            return new CardPlayDecision
            {
                CardPlaySubmissionId = playDecision.CardPlaySubmissionId,
                IsAccepted = playDecision.IsAccepted,
                RejectionReason = playDecision.RejectionReason,
                CommittedMatchStateVersion = playDecision.CommittedMatchStateVersion
            };
        }

        private static PlayerCapturedCardsSnapshot[] CreateCapturedCardsSnapshots(MatchState matchState)
        {
            return matchState.ParticipantUserIds.Select((participantUserId, participantSeat) =>
                new PlayerCapturedCardsSnapshot
                {
                    PlayerUserId = participantUserId,
                    WonTrickCount = matchState.WonTrickCountsBySeat[participantSeat],
                    WonCardIds = matchState.WonCardIdsBySeat[participantSeat].ToArray()
                }).ToArray();
        }

        private static DistressSignalSnapshot CreateDistressSignalSnapshot(MatchState matchState)
        {
            bool hasUsed = matchState.MissionAttempt?.HasUsedDistressSignal ?? false;
            bool isInProgress = matchState.DistressStep !=
                Domain.DistressSignalStep.None &&
                matchState.DistressStep !=
                Domain.DistressSignalStep.Completed && !hasUsed;

            Domain.PassDirection agreedDirection =
                matchState.DistressAgreedDirection ??
                matchState.PendingDistressDirectionsBySeat.Values.FirstOrDefault();

            int[] submittedCardUserIds = matchState.PendingDistressPassCardIdsBySeat.Keys
                .Where(seat => seat < matchState.ParticipantUserIds.Length)
                .Select(seat => matchState.ParticipantUserIds[seat])
                .ToArray();

            int[] votedYesUserIds = matchState.DistressUsageYesVotesBySeat
                .Where(seat => seat < matchState.ParticipantUserIds.Length)
                .Select(seat => matchState.ParticipantUserIds[seat])
                .ToArray();

            int[] directionVotedUserIds = matchState.DistressDirectionVotesBySeat.Keys
                .Where(seat => seat < matchState.ParticipantUserIds.Length)
                .Select(seat => matchState.ParticipantUserIds[seat])
                .ToArray();

            int leftVotes = matchState.DistressDirectionVotesBySeat.Values
                .Count(direction => direction == Domain.PassDirection.Left);
            int rightVotes = matchState.DistressDirectionVotesBySeat.Values
                .Count(direction => direction == Domain.PassDirection.Right);

            return new DistressSignalSnapshot
            {
                HasUsedDistressSignal = hasUsed,
                IsInProgress = isInProgress,
                AgreedDirection = MapDistressPassDirection(agreedDirection),
                SubmittedParticipantUserIds = submittedCardUserIds,
                InitiatorUserId = matchState.DistressInitiatorUserId ?? 0,
                HasBeenRejected = matchState.HasDistressBeenRejected,
                CurrentStep = MapDistressSignalPhase(matchState.DistressStep),
                VotedYesUserIds = votedYesUserIds,
                DirectionVotedUserIds = directionVotedUserIds,
                LeftDirectionVotesCount = leftVotes,
                RightDirectionVotesCount = rightVotes
            };
        }

        private static DistressPassDirection MapDistressPassDirection(
            Domain.PassDirection direction)
        {
            DistressPassDirection mappedDirection = DistressPassDirection.None;
            if (direction == Domain.PassDirection.Left)
            {
                mappedDirection = DistressPassDirection.Left;
            }
            else if (direction == Domain.PassDirection.Right)
            {
                mappedDirection = DistressPassDirection.Right;
            }
            return mappedDirection;
        }

        private static DistressSignalPhase MapDistressSignalPhase(
            Domain.DistressSignalStep step)
        {
            DistressSignalPhase mappedPhase;
            switch (step)
            {
                case Domain.DistressSignalStep.VotingToUse:
                    mappedPhase = DistressSignalPhase.VotingToUse;
                    break;
                case Domain.DistressSignalStep.VotingDirection:
                    mappedPhase = DistressSignalPhase.VotingDirection;
                    break;
                case Domain.DistressSignalStep.SelectingCard:
                    mappedPhase = DistressSignalPhase.SelectingCard;
                    break;
                case Domain.DistressSignalStep.Completed:
                    mappedPhase = DistressSignalPhase.Completed;
                    break;
                case Domain.DistressSignalStep.None:
                default:
                    mappedPhase = DistressSignalPhase.None;
                    break;
            }
            return mappedPhase;
        }
    }
}
