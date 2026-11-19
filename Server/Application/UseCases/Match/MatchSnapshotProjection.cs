using System;
using System.Linq;
using Application.Models;
using Gameplay;

namespace Application.UseCases
{
    /// <summary>Builds fresh recipient-specific arrays; server-owned hands never cross this boundary.</summary>
    internal static partial class MatchSnapshotProjection
    {
        internal static PlayerMatchSnapshot CreateSnapshot(MatchState matchState, int participantSeat,
            long serverTimestampMilliseconds)
        {
            MissionTransitionSnapshot transition = CreateMissionTransition(matchState, serverTimestampMilliseconds);
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
                MissionRetry = CreateMissionRetry(transition),
                MissionEvaluation = CreateMissionEvaluation(matchState),
                MissionPreparation = CreateMissionPreparation(matchState, participantSeat),
                RadioCommunications = CreateRadioCommunicationSnapshots(matchState),
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

        private static PlayerRadioCommunicationSnapshot[] CreateRadioCommunicationSnapshots(MatchState matchState)
        {
            if (matchState.MissionAttempt?.RadioCommunicationsBySeat == null)
            {
                return Array.Empty<PlayerRadioCommunicationSnapshot>();
            }

            PlayerRadioCommunicationSnapshot[] snapshots =
                new PlayerRadioCommunicationSnapshot[matchState.ParticipantUserIds.Length];
            for (int seatIndex = 0; seatIndex < matchState.ParticipantUserIds.Length; seatIndex++)
            {
                TrickTakingMissions.Rules.Models.PlayerRadioCommunicationState commState =
                    seatIndex < matchState.MissionAttempt.RadioCommunicationsBySeat.Count
                        ? matchState.MissionAttempt.RadioCommunicationsBySeat[seatIndex]
                        : null;

                snapshots[seatIndex] = new PlayerRadioCommunicationSnapshot
                {
                    PlayerUserId = matchState.ParticipantUserIds[seatIndex],
                    Seat = (byte)seatIndex,
                    CommunicatedCardId = commState?.CommunicatedCard?.IdCard,
                    TokenPosition = commState?.TokenPosition
                        ?? TrickTakingMissions.Rules.Enums.RadioTokenPosition.Highest,
                    HasUsedCommunicationToken = commState?.HasUsedCommunicationToken ?? false,
                    IsSilencedByCaptain = commState?.IsSilencedByCaptain ?? false
                };
            }

            return snapshots;
        }

        private static DistressSignalSnapshot CreateDistressSignalSnapshot(MatchState matchState)
        {
            bool hasUsed = matchState.MissionAttempt?.HasUsedDistressSignal ?? false;
            bool inProgress = matchState.DistressStep !=
                TrickTakingMissions.Rules.Enums.DistressSignalStep.None &&
                matchState.DistressStep !=
                TrickTakingMissions.Rules.Enums.DistressSignalStep.Completed && !hasUsed;

            TrickTakingMissions.Rules.Enums.PassDirection agreedDirection =
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
                .Count(dir => dir == TrickTakingMissions.Rules.Enums.PassDirection.Left);
            int rightVotes = matchState.DistressDirectionVotesBySeat.Values
                .Count(dir => dir == TrickTakingMissions.Rules.Enums.PassDirection.Right);

            return new DistressSignalSnapshot
            {
                HasUsedDistressSignal = hasUsed,
                IsInProgress = inProgress,
                AgreedDirection = agreedDirection,
                SubmittedParticipantUserIds = submittedCardUserIds,
                InitiatorUserId = matchState.DistressInitiatorUserId ?? 0,
                HasBeenRejected = matchState.HasDistressBeenRejected,
                CurrentStep = matchState.DistressStep,
                VotedYesUserIds = votedYesUserIds,
                DirectionVotedUserIds = directionVotedUserIds,
                LeftDirectionVotesCount = leftVotes,
                RightDirectionVotesCount = rightVotes
            };
        }
    }
}
