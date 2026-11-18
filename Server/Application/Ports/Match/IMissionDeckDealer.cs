using Domain;

namespace Application.Ports
{
    /// <summary>Provides an independently shuffled, separated normal and special card deal.</summary>
    public interface IMissionDeckDealer
    {
        MissionDeal CreateMissionDeal(int participantCount);
        System.Collections.Generic.IReadOnlyList<TrickTakingMissions.Rules.Models.MissionObjective>
            CreateMissionObjectives(TrickTakingMissions.Rules.Models.MissionDefinition definition);
    }
}
