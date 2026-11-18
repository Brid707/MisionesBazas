namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        private const int MissionFiveNumber = 5;
        private const int MissionSixNumber = 6;
        private const int MissionSevenNumber = 7;
        private const int MissionEightNumber = 8;

        private static readonly System.Collections.Generic.IReadOnlyDictionary<int, string> s_missionInstructions =
            new System.Collections.Generic.Dictionary<int, string>
            {
                { MissionFiveNumber, "MissionInstruction_MissionFive_Description" },
                { MissionSixNumber, "MissionInstruction_MissionSix_Description" },
                { MissionSevenNumber, "MissionInstruction_MissionSeven_Description" },
                { MissionEightNumber, "MissionInstruction_MissionEight_Description" }
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
