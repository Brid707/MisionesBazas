namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private const int MissionFiveNumber = 5;
        private const int MissionSixNumber = 6;
        private const int MissionSevenNumber = 7;
        private const int MissionEightNumber = 8;

        private const int MissionNineNumber = 9;
        private const int MissionTenNumber = 10;
        private const int MissionElevenNumber = 11;
        private const int MissionTwelveNumber = 12;
        private const int MissionThirteenNumber = 13;
        private const int MissionFourteenNumber = 14;
        private const int MissionFifteenNumber = 15;
        private const int MissionSixteenNumber = 16;
        private const int MissionSeventeenNumber = 17;
        private const int MissionEighteenNumber = 18;
        private const int MissionNineteenNumber = 19;
        private const int MissionTwentyNumber = 20;

        private const int MissionTwentyOneNumber = 21;
        private const int MissionTwentyTwoNumber = 22;
        private const int MissionTwentyThreeNumber = 23;
        private const int MissionTwentyFourNumber = 24;
        private const int MissionTwentyFiveNumber = 25;
        private const int MissionTwentySixNumber = 26;
        private const int MissionTwentySevenNumber = 27;
        private const int MissionTwentyEightNumber = 28;
        private const int MissionTwentyNineNumber = 29;
        private const int MissionThirtyNumber = 30;
        private const int MissionThirtyOneNumber = 31;
        private const int MissionThirtyTwoNumber = 32;
        private const int MissionThirtyThreeNumber = 33;
        private const int MissionThirtyFourNumber = 34;
        private const int MissionThirtyFiveNumber = 35;

        private const int MissionThirtySixNumber = 36;
        private const int MissionThirtySevenNumber = 37;
        private const int MissionThirtyEightNumber = 38;
        private const int MissionThirtyNineNumber = 39;
        private const int MissionFortyNumber = 40;
        private const int MissionFortyOneNumber = 41;
        private const int MissionFortyTwoNumber = 42;
        private const int MissionFortyThreeNumber = 43;
        private const int MissionFortyFourNumber = 44;
        private const int MissionFortyFiveNumber = 45;
        private const int MissionFortySixNumber = 46;
        private const int MissionFortySevenNumber = 47;
        private const int MissionFortyEightNumber = 48;
        private const int MissionFortyNineNumber = 49;
        private const int MissionFiftyNumber = 50;

        private static readonly System.Collections.Generic.IReadOnlyDictionary<int, string> s_missionInstructions =
            new System.Collections.Generic.Dictionary<int, string>
            {
                { MissionFiveNumber, "MissionInstruction_MissionFive_Description" },
                { MissionSixNumber, "MissionInstruction_MissionSix_Description" },
                { MissionSevenNumber, "MissionInstruction_MissionSeven_Description" },
                { MissionEightNumber, "MissionInstruction_MissionEight_Description" },
                { MissionNineNumber, "MissionInstruction_MissionNine_Description" },
                { MissionTenNumber, "MissionInstruction_MissionTen_Description" },
                { MissionElevenNumber, "MissionInstruction_MissionEleven_Description" },
                { MissionTwelveNumber, "MissionInstruction_MissionTwelve_Description" },
                { MissionThirteenNumber, "MissionInstruction_MissionThirteen_Description" },
                { MissionFourteenNumber, "MissionInstruction_MissionFourteen_Description" },
                { MissionFifteenNumber, "MissionInstruction_MissionFifteen_Description" },
                { MissionSixteenNumber, "MissionInstruction_MissionSixteen_Description" },
                { MissionSeventeenNumber, "MissionInstruction_MissionSeventeen_Description" },
                { MissionEighteenNumber, "MissionInstruction_MissionEighteen_Description" },
                { MissionNineteenNumber, "MissionInstruction_MissionNineteen_Description" },
                { MissionTwentyNumber, "MissionInstruction_MissionTwenty_Description" },
                { MissionTwentyOneNumber, "MissionInstruction_MissionTwentyOne_Description" },
                { MissionTwentyTwoNumber, "MissionInstruction_MissionTwentyTwo_Description" },
                { MissionTwentyThreeNumber, "MissionInstruction_MissionTwentyThree_Description" },
                { MissionTwentyFourNumber, "MissionInstruction_MissionTwentyFour_Description" },
                { MissionTwentyFiveNumber, "MissionInstruction_MissionTwentyFive_Description" },
                { MissionTwentySixNumber, "MissionInstruction_MissionTwentySix_Description" },
                { MissionTwentySevenNumber, "MissionInstruction_MissionTwentySeven_Description" },
                { MissionTwentyEightNumber, "MissionInstruction_MissionTwentyEight_Description" },
                { MissionTwentyNineNumber, "MissionInstruction_MissionTwentyNine_Description" },
                { MissionThirtyNumber, "MissionInstruction_MissionThirty_Description" },
                { MissionThirtyOneNumber, "MissionInstruction_MissionThirtyOne_Description" },
                { MissionThirtyTwoNumber, "MissionInstruction_MissionThirtyTwo_Description" },
                { MissionThirtyThreeNumber, "MissionInstruction_MissionThirtyThree_Description" },
                { MissionThirtyFourNumber, "MissionInstruction_MissionThirtyFour_Description" },
                { MissionThirtyFiveNumber, "MissionInstruction_MissionThirtyFive_Description" },
                { MissionThirtySixNumber, "MissionInstruction_MissionThirtySix_Description" },
                { MissionThirtySevenNumber, "MissionInstruction_MissionThirtySeven_Description" },
                { MissionThirtyEightNumber, "MissionInstruction_MissionThirtyEight_Description" },
                { MissionThirtyNineNumber, "MissionInstruction_MissionThirtyNine_Description" },
                { MissionFortyNumber, "MissionInstruction_MissionForty_Description" },
                { MissionFortyOneNumber, "MissionInstruction_MissionFortyOne_Description" },
                { MissionFortyTwoNumber, "MissionInstruction_MissionFortyTwo_Description" },
                { MissionFortyThreeNumber, "MissionInstruction_MissionFortyThree_Description" },
                { MissionFortyFourNumber, "MissionInstruction_MissionFortyFour_Description" },
                { MissionFortyFiveNumber, "MissionInstruction_MissionFortyFive_Description" },
                { MissionFortySixNumber, "MissionInstruction_MissionFortySix_Description" },
                { MissionFortySevenNumber, "MissionInstruction_MissionFortySeven_Description" },
                { MissionFortyEightNumber, "MissionInstruction_MissionFortyEight_Description" },
                { MissionFortyNineNumber, "MissionInstruction_MissionFortyNine_Description" },
                { MissionFiftyNumber, "MissionInstruction_MissionFifty_Description" }
            };

        public bool IsMissionInstructionVisible =>
            s_missionInstructions.ContainsKey(_confirmedMatchSnapshot?.MissionPreparation?.MissionNumber ?? 0);

        public string MissionInstructionResourceKey => IsMissionInstructionVisible
            ? s_missionInstructions[_confirmedMatchSnapshot.MissionPreparation.MissionNumber] : string.Empty;

        private void NotifyMissionInstructionProperties()
        {
            OnPropertyChanged(nameof(IsMissionInstructionVisible));
            OnPropertyChanged(nameof(MissionInstructionResourceKey));
        }
    }
}
