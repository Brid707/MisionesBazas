using System;
using System.Linq;
using Application.Models;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    /// <summary>Validates a participant play against the authoritative hand and public trick.</summary>
    internal static class MatchPlayValidation
    {
        internal static MatchRejectionReason GetRejection(MatchState matchState, CardPlaySubmission cardPlaySubmission,
            int participantSeat)
        {
            MatchRejectionReason playRejectionReason = MatchRejectionReason.None;
            if (matchState.MissionAttempt?.Phase !=
                TrickTakingMissions.Rules.Enums.MissionAttemptPhase.PlayingTricks)
            {
                playRejectionReason = MatchRejectionReason.MissionPreparationRequired;
            }
            else if (matchState.IsDealCompleted)
            {
                playRejectionReason = MatchRejectionReason.DealCompleted;
            }
            else if (cardPlaySubmission.ExpectedMatchStateVersion != matchState.MatchStateVersion)
            {
                playRejectionReason = MatchRejectionReason.StaleMatchState;
            }
            else
            {
                playRejectionReason = GetTurnAndHandRejection(matchState, cardPlaySubmission, participantSeat);
            }
            return playRejectionReason;
        }

        private static MatchRejectionReason GetTurnAndHandRejection(MatchState matchState,
            CardPlaySubmission cardPlaySubmission, int participantSeat)
        {
            MatchRejectionReason playRejectionReason = MatchRejectionReason.None;
            if (participantSeat != matchState.CurrentTurnPlayerSeat)
            {
                playRejectionReason = MatchRejectionReason.NotPlayerTurn;
            }
            else if (cardPlaySubmission.CardId < 1 || cardPlaySubmission.CardId > DeckRules.TotalDeckSize ||
                !matchState.PlayerHandCardIdsBySeat[participantSeat].Contains(cardPlaySubmission.CardId))
            {
                playRejectionReason = MatchRejectionReason.CardNotInHand;
            }
            else
            {
                playRejectionReason = GetRuleRejection(matchState, cardPlaySubmission.CardId, participantSeat);
            }
            return playRejectionReason;
        }

        private static MatchRejectionReason GetRuleRejection(MatchState matchState, int candidateCardId,
            int participantSeat)
        {
            var playContext = new TrickPlayContext
            {
                PlayerSeat = (byte)participantSeat,
                CurrentTurnSeat = (byte)matchState.CurrentTurnPlayerSeat,
                PlayerCount = matchState.ParticipantUserIds.Length,
                PlayerHand = matchState.PlayerHandCardIdsBySeat[participantSeat]
                    .Select(DeckRules.GetCardById).ToArray(),
                CandidateCard = DeckRules.GetCardById(candidateCardId),
                CurrentTrickPlayedCards = matchState.CurrentTrickCardPlays.Select((play, playOrder) => new TrickCardPlay
                {
                    PlayOrder = (byte)playOrder,
                    Seat = (byte)Array.IndexOf(matchState.ParticipantUserIds, play.PlayerUserId),
                    Card = DeckRules.GetCardById(play.CardId)
                }).ToArray()
            };
            TrickPlayValidationResult validation = TrickFollowSuitRules.ValidatePlay(playContext);
            return validation.IsLegal ? MatchRejectionReason.None : MatchRejectionReason.MustFollowLeadSuit;
        }
    }
}
