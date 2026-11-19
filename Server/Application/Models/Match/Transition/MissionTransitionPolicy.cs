namespace Application.Models
{
    /// <summary>Names countdown and resource budgets with their units and scope.</summary>
    public static class MissionTransitionPolicy
    {
        public const int CountdownMilliseconds = 8000;
        public const int PreparationBackoffMilliseconds = 8000;
        public const int PresenceLeaseSeconds = 6;
        public const int PresenceProbeTimeoutMilliseconds = 1000;
        public const int SchedulerIntervalMilliseconds = 250;
        public const int MaximumConcurrentPreparations = 2;
    }
}
