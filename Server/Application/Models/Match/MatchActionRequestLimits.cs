using System.Collections.Generic;
using System.Diagnostics;

namespace Application.Models
{
    /// <summary>Applies the same monotonic request window before service and application work.</summary>
    public static class MatchActionRequestLimits
    {
        public static MatchActionRequestBudget ConsumeParticipantWindow(
            IDictionary<int, MatchActionRequestBudget> budgetsByParticipant, int participantUserId,
            int maximumRequestsPerSecond)
        {
            budgetsByParticipant.TryGetValue(participantUserId, out MatchActionRequestBudget previousBudget);
            MatchActionRequestBudget consumedBudget = ConsumeWindow(previousBudget, maximumRequestsPerSecond);
            if (consumedBudget != null)
            {
                budgetsByParticipant[participantUserId] = consumedBudget;
            }
            return consumedBudget;
        }

        public static MatchActionRequestBudget ConsumeWindow(
            MatchActionRequestBudget previousBudget, int maximumRequestsPerSecond)
        {
            MatchActionRequestBudget requestBudget = previousBudget ?? new MatchActionRequestBudget();
            long requestTimestamp = Stopwatch.GetTimestamp();
            if (requestTimestamp - requestBudget.WindowStartedTimestamp >= Stopwatch.Frequency)
            {
                requestBudget = requestBudget with { WindowStartedTimestamp = requestTimestamp, RequestsInWindow = 0 };
            }
            MatchActionRequestBudget consumedBudget = null;
            if (requestBudget.RequestsInWindow < maximumRequestsPerSecond)
            {
                consumedBudget = requestBudget with { RequestsInWindow = requestBudget.RequestsInWindow + 1 };
            }
            return consumedBudget;
        }
    }
}
