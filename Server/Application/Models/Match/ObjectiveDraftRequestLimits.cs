using System.Diagnostics;

namespace Application.Models
{
    /// <summary>Applies the same monotonic request window before service and application work.</summary>
    public static class ObjectiveDraftRequestLimits
    {
        public static ObjectiveDraftRequestBudget ConsumeWindow(
            ObjectiveDraftRequestBudget previousBudget, int maximumRequestsPerSecond)
        {
            ObjectiveDraftRequestBudget requestBudget = previousBudget ?? new ObjectiveDraftRequestBudget();
            long requestTimestamp = Stopwatch.GetTimestamp();
            if (requestTimestamp - requestBudget.WindowStartedTimestamp >= Stopwatch.Frequency)
            {
                requestBudget = requestBudget with { WindowStartedTimestamp = requestTimestamp, RequestsInWindow = 0 };
            }
            ObjectiveDraftRequestBudget consumedBudget = null;
            if (requestBudget.RequestsInWindow < maximumRequestsPerSecond)
            {
                consumedBudget = requestBudget with { RequestsInWindow = requestBudget.RequestsInWindow + 1 };
            }
            return consumedBudget;
        }
    }
}
