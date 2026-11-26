using System;
using System.Collections.Generic;
using TrickTakingMissions.Rules.Enums;

using Domain;

namespace Application.Models
{
    public sealed class MatchSpecialPreparationState
    {
        public Guid MissionPreparationStageId { get; private set; }
        public long PreparationStageOpenedVersion { get; private set; }
        public IReadOnlyDictionary<byte, BlindObjectiveCapableResponse> BlindResponsesBySeat { get; private set; } =
            new Dictionary<byte, BlindObjectiveCapableResponse>();
        public Dictionary<Guid, ProcessedMissionPreparation> ProcessedPreparationSubmissions { get; } =
            new Dictionary<Guid, ProcessedMissionPreparation>();
        public Dictionary<int, MatchActionRequestBudget> PreparationBudgetsByParticipant { get; } =
            new Dictionary<int, MatchActionRequestBudget>();

        public MissionPreparationCommit CommitSpecialPreparation(MissionPreparationRequest request,
            int participantUserId, SpecialPreparationChange preparedChange, long committedVersion)
        {
            var commit = new MissionPreparationCommit
            {
                MissionPreparationSubmissionId = request.MissionPreparationSubmissionId,
                CommittedMatchStateVersion = committedVersion,
                HasStateChanged = true
            };
            var retained = new ProcessedMissionPreparation
            {
                ParticipantUserId = participantUserId,
                Request = request,
                Commit = commit
            };
            Guid nextStageId = preparedChange.HasStageChanged ? Guid.NewGuid() : MissionPreparationStageId;
            ProcessedPreparationSubmissions.Add(request.MissionPreparationSubmissionId, retained);
            BlindResponsesBySeat = preparedChange.ResponsesBySeat;
            if (preparedChange.HasStageChanged)
            {
                MissionPreparationStageId = nextStageId;
                PreparationStageOpenedVersion = committedVersion;
            }
            return commit;
        }

        public void ResetSpecialPreparationState(long matchStateVersion, bool isInitialAttempt)
        {
            MissionPreparationStageId = Guid.NewGuid();
            PreparationStageOpenedVersion = matchStateVersion + (isInitialAttempt ? 0 : 1);
            BlindResponsesBySeat = new Dictionary<byte, BlindObjectiveCapableResponse>();
            ProcessedPreparationSubmissions.Clear();
        }
    }
}
