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
                { MissionTwentyNumber, "MissionInstruction_MissionTwenty_Description" }
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
