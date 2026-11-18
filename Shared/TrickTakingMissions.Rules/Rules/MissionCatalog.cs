using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace TrickTakingMissions.Rules.Rules
{
    /// <summary>
    /// Provides the official catalog of the 50 missions, their required objectives, order tokens, and gameplay constraints.
    /// </summary>
    public static class MissionCatalog
    {
        public const int MinimumMissionNumber = 1;
        public const int MaximumMissionNumber = 50;

        private static readonly IReadOnlyDictionary<int, MissionDefinition> _missions = BuildCatalog();
        private static readonly IReadOnlyList<MissionDefinition> _allMissions = BuildAllMissionsList(_missions);

        /// <summary>
        /// Retrieves the immutable mission definition for the specified mission number.
        /// </summary>
        /// <param name="missionNumber">The mission number between <see cref="MinimumMissionNumber"/> and <see cref="MaximumMissionNumber"/>.</param>
        /// <returns>The official <see cref="MissionDefinition"/>.</returns>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when the mission number is outside supported bounds.</exception>
        public static MissionDefinition GetMission(int missionNumber)
        {
            if (missionNumber < MinimumMissionNumber || missionNumber > MaximumMissionNumber)
            {
                throw new ArgumentOutOfRangeException(nameof(missionNumber));
            }

            return _missions[missionNumber];
        }

        /// <summary>
        /// Retrieves all 50 official mission definitions ordered by mission number.
        /// </summary>
        /// <returns>An immutable list containing all 50 mission definitions.</returns>
        public static IReadOnlyList<MissionDefinition> GetAllMissions()
        {
            return _allMissions;
        }

        private static IReadOnlyList<MissionDefinition> BuildAllMissionsList(IReadOnlyDictionary<int, MissionDefinition> missions)
        {
            var orderedList = new List<MissionDefinition>(missions.Count);
            for (int missionIndex = MinimumMissionNumber; missionIndex <= MaximumMissionNumber; missionIndex++)
            {
                orderedList.Add(missions[missionIndex]);
            }

            return orderedList.AsReadOnly();
        }

        private static IReadOnlyDictionary<int, MissionDefinition> BuildCatalog()
        {
            var missions = new Dictionary<int, MissionDefinition>(MaximumMissionNumber);

            RegisterMission(missions, new MissionDefinition { MissionNumber = 1, ObjectiveCardCount = 1, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 1 objective." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 2, ObjectiveCardCount = 2, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 2 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 3, ObjectiveCardCount = 2, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 2 objectives in strict order (1, 2)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 4, ObjectiveCardCount = 3, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 3 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 5, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M05_OnePlayerWinsNoTricks, Description = "One player must not win any tricks." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 6, ObjectiveCardCount = 3, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo }), CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 3 objectives (> before >>). Interference active." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 7, ObjectiveCardCount = 3, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 3 objectives (Omega token completed last)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 8, ObjectiveCardCount = 3, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo, ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 3 objectives in strict order (1, 2, 3)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 9, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M09_WinTrickWithNumberOne, Description = "A non-special card with value 1 must win a trick." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 10, ObjectiveCardCount = 4, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 4 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 11, ObjectiveCardCount = 4, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M11_CaptainSilencesOnePlayer, Description = "Complete 4 objectives (token 1 first). Commander selects a player who cannot communicate." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 12, ObjectiveCardCount = 4, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 4 objectives (Omega token completed last)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 13, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M13_WinTrickWithEverySpecialCard, Description = "A trick must be won with each of the special cards." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 14, ObjectiveCardCount = 4, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 4 objectives (>, >>, >>> in relative precedence). Interference active." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 15, ObjectiveCardCount = 4, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo, ObjectiveTokenType.OrderThree, ObjectiveTokenType.OrderFour }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 4 objectives in strict order (1, 2, 3, 4)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 16, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M16_NoTrickWonWithNumberNine, Description = "No trick must be won with a card of value 9." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 17, ObjectiveCardCount = 2, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M17_NoTrickWonWithNumberNine, Description = "Complete 2 objectives. No trick must be won with a card of value 9." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 18, ObjectiveCardCount = 5, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.DisruptionUntilTrick2, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 5 objectives. Communication disrupted until trick 2." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 19, ObjectiveCardCount = 5, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne }), CommunicationRule = CommunicationRuleType.DisruptionUntilTrick3, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 5 objectives (token 1 first). Communication disrupted until trick 3." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 20, ObjectiveCardCount = 2, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer, Description = "Complete 2 objectives. Commander assigns all objectives to a single player." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 21, ObjectiveCardCount = 5, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 5 objectives (token 1 before token 2)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 22, ObjectiveCardCount = 5, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree, ObjectiveTokenType.ArrowFour }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 5 objectives in relative precedence (>, >>, >>>, >>>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 23, ObjectiveCardCount = 5, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo, ObjectiveTokenType.OrderThree, ObjectiveTokenType.OrderFour, ObjectiveTokenType.OrderFive }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 5 objectives in strict order (1, 2, 3, 4, 5)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 24, ObjectiveCardCount = 6, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 6 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 25, ObjectiveCardCount = 6, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo }), CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 6 objectives (> before >>). Interference active." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 26, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M26_TwoTricksWonWithNumberOne, Description = "Two non-special cards with value 1 must win a trick." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 27, ObjectiveCardCount = 3, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer, Description = "Complete 3 objectives. Commander assigns all objectives to a single player." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 28, ObjectiveCardCount = 6, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.Omega }), CommunicationRule = CommunicationRuleType.DisruptionUntilTrick3, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 6 objectives (token 1 first, Omega last). Communication disrupted until trick 3." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 29, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.M29_MaxTrickDifferenceTwo, Description = "Interference active. At no point may any player have won more than two tricks more than any other player." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 30, ObjectiveCardCount = 6, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 6 objectives in relative precedence (>, >>, >>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 31, ObjectiveCardCount = 6, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo, ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 6 objectives in strict order (1, 2, 3)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 32, ObjectiveCardCount = 7, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 7 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 33, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard, Description = "Commander selects a player to win exactly one trick without using a special card." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 34, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo, Description = "Commander must win first and last trick. No player may have won more than two tricks more than any other player." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 35, ObjectiveCardCount = 7, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 7 objectives in relative precedence (>, >>, >>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 36, ObjectiveCardCount = 7, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 7 objectives in strict order (1, 2)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 37, ObjectiveCardCount = 4, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 4 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 38, ObjectiveCardCount = 8, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 8 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 39, ObjectiveCardCount = 8, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 8 objectives in relative precedence (>, >>, >>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 40, ObjectiveCardCount = 8, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo, ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 8 objectives in strict order (1, 2, 3)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 41, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard, Description = "Commander selects a player to win only the first and last trick without using a special card." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 42, ObjectiveCardCount = 9, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 9 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 43, ObjectiveCardCount = 9, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 9 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 44, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder, Description = "Each special card must win a trick in ascending order (Diamond, Club, Heart, Spade)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 45, ObjectiveCardCount = 9, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 9 objectives in relative precedence (>, >>, >>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 46, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts, Description = "Player with Heart 9 must identify themselves. Player to their left must win all Heart cards." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 47, ObjectiveCardCount = 10, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 10 objectives." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 48, ObjectiveCardCount = 3, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick, Description = "Complete 3 objectives. The Omega objective must be completed in the final trick." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 49, ObjectiveCardCount = 10, Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo, ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None, Description = "Complete 10 objectives in relative precedence (>, >>, >>>)." });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 50, ObjectiveCardCount = 0, Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.M50_SplitTrickWinsDistribution, Description = "One player must win the first four tricks, another the last trick, and remaining players must win the rest. Commander assigns roles." });

            return missions;
        }

        private static void RegisterMission(Dictionary<int, MissionDefinition> missions, MissionDefinition definition)
        {
            missions.Add(definition.MissionNumber, definition);
        }
    }
}
