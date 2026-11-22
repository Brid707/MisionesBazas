using System;

namespace Application.Models
{
    public sealed class MatchTransitionState
    {
        public MissionTransitionScheduleStatus MissionTransitionStatus { get; private set; }

        public MissionTransitionAction TransitionAction { get; private set; }

        public int DestinationMissionNumber { get; private set; }

        public bool HasStartedTransitionExecution { get; private set; }

        public Guid MissionTransitionScheduleId { get; private set; }

        public long MissionTransitionDeadlineMilliseconds { get; private set; }

        public long MissionTransitionConnectionVersion { get; private set; }

        public int[] MissingTransitionParticipantUserIds { get; private set; } = Array.Empty<int>();

        public void ConfigureMissionTransition(MissionTransitionAction transitionAction, int destinationMissionNumber)
        {
            TransitionAction = transitionAction;
            DestinationMissionNumber = destinationMissionNumber;
        }

        public void SetMissionTransitionSchedule(MissionTransitionScheduleStatus status,
            MatchParticipantPresence presence,
            long deadlineMilliseconds)
        {
            MissionTransitionStatus = status;
            HasStartedTransitionExecution = false;
            MissionTransitionScheduleId = Guid.NewGuid();
            MissionTransitionConnectionVersion = presence.ConnectionVersion;
            MissingTransitionParticipantUserIds = (int[])presence.MissingParticipantUserIds.Clone();
            MissionTransitionDeadlineMilliseconds = deadlineMilliseconds;
        }

        public void ReserveMissionTransitionPreparation()
        {
            MissionTransitionStatus = MissionTransitionScheduleStatus.Preparing;
        }

        public void MarkTransitionExecutionStarted()
        {
            HasStartedTransitionExecution = true;
        }

        public void Reset(int destinationMissionNumber)
        {
            TransitionAction = MissionTransitionAction.None;
            DestinationMissionNumber = destinationMissionNumber;
            MissionTransitionStatus = MissionTransitionScheduleStatus.Inactive;
            HasStartedTransitionExecution = false;
            MissionTransitionScheduleId = Guid.Empty;
            MissionTransitionDeadlineMilliseconds = 0;
            MissionTransitionConnectionVersion = 0;
            MissingTransitionParticipantUserIds = Array.Empty<int>();
        }
    }
}
