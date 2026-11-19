using System;
using System.Collections.Generic;

namespace Application.Models
{
    public sealed partial class MatchState
    {
        public Dictionary<int, CommittedRadioCommunication> RadioCommunicationsByParticipantUserId { get; } =
            new Dictionary<int, CommittedRadioCommunication>();
        public Dictionary<Guid, CommittedRadioCommunication> ProcessedRadioCommunicationsBySubmissionId { get; } =
            new Dictionary<Guid, CommittedRadioCommunication>();
        public Dictionary<int, MatchActionRequestBudget> RadioBudgetsByParticipantUserId { get; } =
            new Dictionary<int, MatchActionRequestBudget>();

        internal RadioCommunicationCommit CommitRadioCommunication(CommittedRadioCommunication communication)
        {
            RadioCommunicationsByParticipantUserId.Add(communication.ParticipantUserId, communication);
            ProcessedRadioCommunicationsBySubmissionId.Add(communication.Request.RadioCommunicationSubmissionId,
                communication);
            MatchStateVersion++;
            return new RadioCommunicationCommit
            {
                RadioCommunicationSubmissionId = communication.Request.RadioCommunicationSubmissionId,
                CommittedMatchStateVersion = MatchStateVersion,
                HasStateChanged = true
            };
        }
    }
}
