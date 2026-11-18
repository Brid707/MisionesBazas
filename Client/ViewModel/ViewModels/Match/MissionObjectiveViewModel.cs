using System;
using Gameplay;

namespace ViewModel.ViewModels
{
    public sealed class MissionObjectiveViewModel
    {
        public MissionObjectiveViewModel(MissionObjectiveSnapshot objective)
        {
            MissionObjectiveId = objective.MissionObjectiveId;
            CardId = objective.CardId;
            Token = objective.Token;
        }

        public Guid MissionObjectiveId { get; }
        public int? CardId { get; }
        public MissionObjectiveToken Token { get; }
    }
}
