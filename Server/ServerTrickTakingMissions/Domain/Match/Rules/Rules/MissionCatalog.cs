using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;
using TrickTakingMissions.Rules.Models;

namespace Domain
{
    /// <summary>
    /// Provides the official catalog of the 50 missions, their required objectives, order tokens, and gameplay constraints.
    /// </summary>
    public static class MissionCatalog
    {
        public const int MinimumMissionNumber = 1;
        public const int MaximumMissionNumber = 50;

        private const int ZeroObjectivesCount = 0;
        private const int OneObjectiveCount = 1;
        private const int TwoObjectivesCount = 2;
        private const int ThreeObjectivesCount = 3;
        private const int FourObjectivesCount = 4;
        private const int FiveObjectivesCount = 5;
        private const int SixObjectivesCount = 6;
        private const int SevenObjectivesCount = 7;
        private const int EightObjectivesCount = 8;
        private const int NineObjectivesCount = 9;
        private const int TenObjectivesCount = 10;

        private const string Mission01Description = "Complete 1 objective.";
        private const string Mission02Description = "Complete 2 objectives.";
        private const string Mission03Description = "Complete 2 objectives in strict order (1, 2).";
        private const string Mission04Description = "Complete 3 objectives.";
        private const string Mission05Description = "One player must not win any tricks.";
        private const string Mission06Description = "Complete 3 objectives (> before >>). Interference active.";
        private const string Mission07Description = "Complete 3 objectives (Omega token completed last).";
        private const string Mission08Description = "Complete 3 objectives in strict order (1, 2, 3).";
        private const string Mission09Description = "A non-special card with value 1 must win a trick.";
        private const string Mission10Description = "Complete 4 objectives.";
        private const string Mission11Description = "Complete 4 objectives (token 1 first). Commander selects a " +
            "player who cannot communicate.";
        private const string Mission12Description = "Complete 4 objectives (Omega token completed last).";
        private const string Mission13Description = "A trick must be won with each of the special cards.";
        private const string Mission14Description = "Complete 4 objectives (>, >>, >>> in relative precedence). " +
            "Interference active.";
        private const string Mission15Description = "Complete 4 objectives in strict order (1, 2, 3, 4).";
        private const string Mission16Description = "No trick must be won with a card of value 9.";
        private const string Mission17Description = "Complete 2 objectives. No trick must be won with a card of " +
            "value 9.";
        private const string Mission18Description = "Complete 5 objectives. Communication disrupted until trick 2.";
        private const string Mission19Description = "Complete 5 objectives (token 1 first). Communication disrupted " +
            "until trick 3.";
        private const string Mission20Description = "Complete 2 objectives. Commander assigns all objectives to a " +
            "single player.";
        private const string Mission21Description = "Complete 5 objectives (token 1 before token 2).";
        private const string Mission22Description = "Complete 5 objectives in relative precedence (>, >>, >>>, >>>>).";
        private const string Mission23Description = "Complete 5 objectives in strict order (1, 2, 3, 4, 5).";
        private const string Mission24Description = "Complete 6 objectives.";
        private const string Mission25Description = "Complete 6 objectives (> before >>). Interference active.";
        private const string Mission26Description = "Two non-special cards with value 1 must win a trick.";
        private const string Mission27Description = "Complete 3 objectives. Commander assigns all objectives to a " +
            "single player.";
        private const string Mission28Description = "Complete 6 objectives (token 1 first, Omega last). " +
            "Communication disrupted until trick 3.";
        private const string Mission29Description = "Interference active. At no point may any player have won more " +
            "than two tricks more than any other player.";
        private const string Mission30Description = "Complete 6 objectives in relative precedence (>, >>, >>>).";
        private const string Mission31Description = "Complete 6 objectives in strict order (1, 2, 3).";
        private const string Mission32Description = "Complete 7 objectives.";
        private const string Mission33Description = "Commander selects a player to win exactly one trick without " +
            "using a special card.";
        private const string Mission34Description = "Commander must win first and last trick. No player may " +
            "have won more than two tricks more than any other player.";
        private const string Mission35Description = "Complete 7 objectives in relative precedence (>, >>, >>>).";
        private const string Mission36Description = "Complete 7 objectives in strict order (1, 2).";
        private const string Mission37Description = "Complete 4 objectives.";
        private const string Mission38Description = "Complete 8 objectives.";
        private const string Mission39Description = "Complete 8 objectives in relative precedence (>, >>, >>>).";
        private const string Mission40Description = "Complete 8 objectives in strict order (1, 2, 3).";
        private const string Mission41Description = "Commander selects a player to win only the first and last " +
            "trick without using a special card.";
        private const string Mission42Description = "Complete 9 objectives.";
        private const string Mission43Description = "Complete 9 objectives.";
        private const string Mission44Description = "Each special card must win a trick in ascending order " +
            "(Diamond, Club, Heart, Spade).";
        private const string Mission45Description = "Complete 9 objectives in relative precedence (>, >>, >>>).";
        private const string Mission46Description = "Player with Heart 9 must identify themselves. Player to their " +
            "left must win all Heart cards.";
        private const string Mission47Description = "Complete 10 objectives.";
        private const string Mission48Description = "Complete 3 objectives. The Omega objective must be completed " +
            "in the final trick.";
        private const string Mission49Description = "Complete 10 objectives in relative precedence (>, >>, >>>).";
        private const string Mission50Description = "One player must win the first four tricks, another the last " +
            "trick, and remaining players must win the rest. Commander assigns roles.";

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

        private static IReadOnlyList<MissionDefinition> BuildAllMissionsList(IReadOnlyDictionary<int,
            MissionDefinition> missions)
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

            RegisterMission(missions, new MissionDefinition { MissionNumber = 1, ObjectiveCardCount = OneObjectiveCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission01Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 2, ObjectiveCardCount = TwoObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission02Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 3, ObjectiveCardCount = TwoObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission03Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 4, ObjectiveCardCount = ThreeObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission04Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 5, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M05_OnePlayerWinsNoTricks,
                Description = Mission05Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 6,
                ObjectiveCardCount = ThreeObjectivesCount, Tokens = Array.AsReadOnly(new[]
                { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo }),
                CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission06Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 7, ObjectiveCardCount = ThreeObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission07Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 8, ObjectiveCardCount = ThreeObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo,
                    ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission08Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 9, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M09_WinTrickWithNumberOne,
                Description = Mission09Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 10, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission10Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 11, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne }),
                CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M11_CaptainSilencesOnePlayer,
                Description = Mission11Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 12, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission12Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 13, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M13_WinTrickWithEverySpecialCard,
                Description = Mission13Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 14, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Interference,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission14Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 15, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo,
                    ObjectiveTokenType.OrderThree, ObjectiveTokenType.OrderFour }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission15Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 16, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M16_NoTrickWonWithNumberNine,
                Description = Mission16Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 17, ObjectiveCardCount = TwoObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M17_NoTrickWonWithNumberNine,
                Description = Mission17Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 18, ObjectiveCardCount = FiveObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(),
                CommunicationRule = CommunicationRuleType.DisruptionUntilTrick2,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission18Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 19, ObjectiveCardCount = FiveObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne }),
                CommunicationRule = CommunicationRuleType.DisruptionUntilTrick3,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission19Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 20, ObjectiveCardCount = TwoObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M20_CaptainAssignsAllObjectivesToOnePlayer,
                Description = Mission20Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 21, ObjectiveCardCount = FiveObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission21Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 22, ObjectiveCardCount = FiveObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree, ObjectiveTokenType.ArrowFour }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission22Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 23, ObjectiveCardCount = FiveObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo,
                    ObjectiveTokenType.OrderThree, ObjectiveTokenType.OrderFour, ObjectiveTokenType.OrderFive }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission23Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 24, ObjectiveCardCount = SixObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission24Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 25, ObjectiveCardCount = SixObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo }),
                CommunicationRule = CommunicationRuleType.Interference, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission25Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 26, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M26_TwoTricksWonWithNumberOne,
                Description = Mission26Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 27, ObjectiveCardCount = ThreeObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M27_CaptainAssignsAllObjectivesToOnePlayer,
                Description = Mission27Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 28, ObjectiveCardCount = SixObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.Omega }),
                CommunicationRule = CommunicationRuleType.DisruptionUntilTrick3,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission28Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 29, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Interference,
                SpecialRule = SpecialMissionRuleType.M29_MaxTrickDifferenceTwo,
                Description = Mission29Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 30, ObjectiveCardCount = SixObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission30Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 31, ObjectiveCardCount = SixObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo,
                    ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission31Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 32, ObjectiveCardCount = SevenObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission32Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 33, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard,
                Description = Mission33Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 34, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo,
                Description = Mission34Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 35, ObjectiveCardCount = SevenObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission35Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 36, ObjectiveCardCount = SevenObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo }),
                CommunicationRule = CommunicationRuleType.Standard, SpecialRule = SpecialMissionRuleType.None,
                Description = Mission36Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 37, ObjectiveCardCount = FourObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission37Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 38, ObjectiveCardCount = EightObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission38Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 39, ObjectiveCardCount = EightObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission39Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 40, ObjectiveCardCount = EightObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.OrderOne, ObjectiveTokenType.OrderTwo,
                    ObjectiveTokenType.OrderThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission40Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 41, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard,
                Description = Mission41Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 42, ObjectiveCardCount = NineObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission42Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 43, ObjectiveCardCount = NineObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission43Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 44, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M44_SpecialCardsWinTricksInAscendingOrder,
                Description = Mission44Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 45, ObjectiveCardCount = NineObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission45Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 46, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M46_SeatLeftOfHeartNineWinsAllHearts,
                Description = Mission46Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 47, ObjectiveCardCount = TenObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None, Description = Mission47Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 48, ObjectiveCardCount = ThreeObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.Omega }),
                CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M48_OmegaObjectiveCompletedInLastTrick,
                Description = Mission48Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 49, ObjectiveCardCount = TenObjectivesCount,
                Tokens = Array.AsReadOnly(new[] { ObjectiveTokenType.ArrowOne, ObjectiveTokenType.ArrowTwo,
                    ObjectiveTokenType.ArrowThree }), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.None,
                Description = Mission49Description });
            RegisterMission(missions, new MissionDefinition { MissionNumber = 50, ObjectiveCardCount = ZeroObjectivesCount,
                Tokens = Array.Empty<ObjectiveTokenType>(), CommunicationRule = CommunicationRuleType.Standard,
                SpecialRule = SpecialMissionRuleType.M50_SplitTrickWinsDistribution,
                Description = Mission50Description });

            return missions;
        }

        private static void RegisterMission(Dictionary<int, MissionDefinition> missions, MissionDefinition definition)
        {
            missions.Add(definition.MissionNumber, definition);
        }
    }
}
