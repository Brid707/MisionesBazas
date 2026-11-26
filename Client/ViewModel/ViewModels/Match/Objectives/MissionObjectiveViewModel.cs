using System;
using Model.GameServices;

namespace ViewModel.ViewModels
{
    public sealed class MissionObjectiveViewModel
    {
        public MissionObjectiveViewModel(MissionObjectiveSnapshot objective)
        {
            MissionObjectiveId = objective.MissionObjectiveId;
            CardId = objective.CardId;
            Token = objective.Token;
            Status = objective.Status;
            CompletedAtTrickNumber = objective.CompletedAtTrickNumber;
        }

        public Guid MissionObjectiveId { get; }
        public int? CardId { get; }
        public MissionObjectiveToken Token { get; }

        public MissionObjectiveStatus Status { get; }

        public int? CompletedAtTrickNumber { get; }

        public bool IsCompleted => Status == MissionObjectiveStatus.Completed;

        public bool IsFailed => Status == MissionObjectiveStatus.Failed;

        public string ObjectiveStatusResourceKey => "MissionEvaluation_Objective_" + Status;
    }
}
