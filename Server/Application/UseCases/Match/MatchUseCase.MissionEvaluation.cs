using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using Gameplay;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private static CompletedTrickResolution PrepareCompletedTrick(MatchState matchState,
            MatchCardPlay[] completedTrickPlays)
        {
            TrickCardPlay[] domainTrickPlays = completedTrickPlays.Select((play, playOrder) => new TrickCardPlay
            {
                PlayOrder = (byte)playOrder,
                Seat = (byte)Array.IndexOf(matchState.ParticipantUserIds, play.PlayerUserId),
                Card = DeckRules.GetCardById(play.CardId)
            }).ToArray();
            TrickCardPlay winningTrickPlay = TrickWinnerRules.DetermineTrickWinner(domainTrickPlays);
            PreparedTrickEvaluation preparedEvaluation = CreateMissionEvaluationContext(
                matchState, domainTrickPlays, winningTrickPlay);
            MissionEvaluationResult missionEvaluationResult =
                MissionEvaluationRules.EvaluateCompletedTrick(preparedEvaluation.Context);
            MissionAttemptState updatedMissionAttempt = matchState.MissionAttempt with
            {
                Objectives = missionEvaluationResult.UpdatedObjectives.ToArray(),
                Status = missionEvaluationResult.OverallStatus,
                Phase = missionEvaluationResult.OverallStatus == MissionAttemptStatus.InProgress
                    ? MissionAttemptPhase.PlayingTricks : MissionAttemptPhase.Finished
            };
            return new CompletedTrickResolution
            {
                CompletedTrickCardPlays = completedTrickPlays,
                WinningParticipantSeat = winningTrickPlay.Seat,
                CompletedTrickNumber = matchState.CurrentTrickNumber,
                MissionEvaluation = missionEvaluationResult,
                TrickStatistics = preparedEvaluation.Statistics,
                UpdatedMissionAttempt = updatedMissionAttempt
            };
        }

        private static PreparedTrickEvaluation CreateMissionEvaluationContext(MatchState matchState,
            TrickCardPlay[] completedTrickPlays, TrickCardPlay winningTrickPlay)
        {
            MissionDefinition missionDefinition = MissionCatalog.GetMission(matchState.MissionAttempt.MissionNumber);
            if (!MissionAttemptPreparation.CanPrepareMission(missionDefinition.MissionNumber))
            {
                throw new InvalidOperationException(nameof(missionDefinition.SpecialRule));
            }
            MissionTrickStatistics candidateStatistics =
                matchState.TrickStatistics.IncludeWinner(winningTrickPlay.Card);
            var context = new MissionEvaluationContext
            {
                Definition = missionDefinition,
                TotalTricksInMission = matchState.MaximumMissionTrickCount,
                CurrentTrickNumber = matchState.CurrentTrickNumber,
                WinningPlay = winningTrickPlay,
                CompletedTrickPlays = completedTrickPlays,
                CurrentObjectives = matchState.MissionAttempt.Objectives,
                TotalTricksWonBySeat = CreateCandidateTrickWinCounts(matchState, winningTrickPlay.Seat),
                CaptainSeat = (byte)matchState.MissionCaptainSeat,
                PlayerCount = matchState.ParticipantUserIds.Length,
                RoleConfig = matchState.MissionAttempt.RoleConfig,
                TricksWonWithNormalOneCount = candidateStatistics.TricksWonWithNormalOneCount,
                SpecialCardsWonSoFar = candidateStatistics.SpecialWinningCardIds.Select(DeckRules.GetCardById).ToArray()
            };
            return new PreparedTrickEvaluation { Context = context, Statistics = candidateStatistics };
        }
        private static IReadOnlyDictionary<int, int> CreateCandidateTrickWinCounts(MatchState matchState,
            int winningParticipantSeat)
        {
            Dictionary<int, int> candidateTrickWinCountsBySeat = matchState.WonTrickCountsBySeat
                .Select((trickWinCount, participantSeat) => new { participantSeat, trickWinCount })
                .ToDictionary(entry => entry.participantSeat, entry => entry.trickWinCount);
            candidateTrickWinCountsBySeat[winningParticipantSeat]++;
            return candidateTrickWinCountsBySeat;
        }
    }
}
