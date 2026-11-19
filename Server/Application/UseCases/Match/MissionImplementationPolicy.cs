using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    internal static class MissionImplementationPolicy
    {
        private const int MaximumImplementedMissionNumber = 35;

        internal static bool CanPrepare(int missionNumber)
        {
            return missionNumber >= MissionCatalog.MinimumMissionNumber &&
                missionNumber <= MaximumImplementedMissionNumber;
        }
    }
}
