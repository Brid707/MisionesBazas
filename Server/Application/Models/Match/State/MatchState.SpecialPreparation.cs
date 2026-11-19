using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;

namespace Application.Models
{
    public sealed partial class MatchState
    {
        public Guid MissionPreparationStageId { get; private set; }
        public long PreparationStageOpenedVersion { get; private set; }
        public IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> BlindResponsesBySeat { get; private set; } =
            new Dictionary<byte, BlindObjectiveCapableResponse>();
        public Dictionary<Guid, ProcessedMissionPreparation> ProcessedPreparationSubmissions { get; } =
            new Dictionary<Guid, ProcessedMissionPreparation>();
        public Dictionary<int, MatchActionRequestBudget> PreparationBudgetsByParticipant { get; } =
            new Dictionary<int, MatchActionRequestBudget>();

        internal MissionPreparationCommit CommitSpecialPreparation(MissionPreparationRequest request,
            int participantUserId, SpecialPreparationChange preparedChange)
        {
            var commit = new MissionPreparationCommit
            {
                MissionPreparationSubmissionId = request.MissionPreparationSubmissionId,
                CommittedMatchStateVersion = MatchStateVersion + 1,
                HasStateChanged = true
            };
            var retained = new ProcessedMissionPreparation { ParticipantUserId = participantUserId,
                Request = request, Commit = commit };
            Guid nextStageId = preparedChange.HasStageChanged ? Guid.NewGuid() : MissionPreparationStageId;
            ProcessedPreparationSubmissions.Add(request.MissionPreparationSubmissionId, retained);
            MissionAttempt = preparedChange.UpdatedAttempt;
            BlindResponsesBySeat = preparedChange.ResponsesBySeat;
            MatchStateVersion = commit.CommittedMatchStateVersion;
            if (preparedChange.HasStageChanged)
            {
                MissionPreparationStageId = nextStageId;
                PreparationStageOpenedVersion = MatchStateVersion;
            }
            return commit;
        }

        private void ResetSpecialPreparationState(bool isInitialAttempt)
        {
            TrickStatistics = new MissionTrickStatistics();
            MissionPreparationStageId = Guid.NewGuid();
            PreparationStageOpenedVersion = MatchStateVersion + (isInitialAttempt ? 0 : 1);
            BlindResponsesBySeat = new Dictionary<byte, BlindObjectiveCapableResponse>();
            ProcessedPreparationSubmissions.Clear();
        }
    }
}
