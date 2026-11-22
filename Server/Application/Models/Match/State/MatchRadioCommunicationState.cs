using System;
using System.Collections.Generic;

namespace Application.Models
{
    public sealed class MatchRadioCommunicationState
    {
        public Dictionary<int, CommittedRadioCommunication> RadioCommunicationsByParticipantUserId { get; } =
            new Dictionary<int, CommittedRadioCommunication>();
        public Dictionary<Guid, CommittedRadioCommunication> ProcessedRadioCommunicationsBySubmissionId { get; } =
            new Dictionary<Guid, CommittedRadioCommunication>();
        public Dictionary<int, MatchActionRequestBudget> RadioBudgetsByParticipantUserId { get; } =
            new Dictionary<int, MatchActionRequestBudget>();

        public RadioCommunicationCommit CommitRadioCommunication(CommittedRadioCommunication communication,
            long committedMatchStateVersion)
        {
            RadioCommunicationsByParticipantUserId.Add(communication.ParticipantUserId, communication);
            ProcessedRadioCommunicationsBySubmissionId.Add(communication.Request.RadioCommunicationSubmissionId,
                communication);
            return new RadioCommunicationCommit
            {
                RadioCommunicationSubmissionId = communication.Request.RadioCommunicationSubmissionId,
                CommittedMatchStateVersion = committedMatchStateVersion,
                HasStateChanged = true
            };
        }

        public void Clear()
        {
            RadioCommunicationsByParticipantUserId.Clear();
            ProcessedRadioCommunicationsBySubmissionId.Clear();
        }
    }
}
