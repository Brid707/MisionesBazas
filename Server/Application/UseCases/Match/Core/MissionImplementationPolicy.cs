using TrickTakingMissions.Rules.Models;
using TrickTakingMissions.Rules.Rules;

using Domain;

namespace Application.UseCases
{
    internal static class MissionImplementationPolicy
    {
        private const int MaximumImplementedMissionNumber = 50;

        internal static bool CanPrepare(int missionNumber)
        {
            return missionNumber >= MissionCatalog.MinimumMissionNumber &&
                missionNumber <= MaximumImplementedMissionNumber;
        }
    }
}
