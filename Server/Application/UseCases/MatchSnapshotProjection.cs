using System;
using System.Linq;
using Application.Models;
using Gameplay;

namespace Application.UseCases
{
    /// <summary>Builds fresh recipient-specific arrays; server-owned hands never cross this boundary.</summary>
    internal static class MatchSnapshotProjection
    {
        internal static PlayerMatchSnapshot CreateSnapshot(MatchState matchState, int participantSeat)
        {
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
                LastTrickWinnerUserId = matchState.LastTrickWinnerUserId
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
    }
}
