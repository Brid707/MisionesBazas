using System;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.UseCases
{
    internal static class MatchTransitionDestinationCalculator
    {
        internal static bool ResolveMissionTransition(MatchState matchState)
        {
            MissionTransitionScheduleStatus terminalStatus = MissionTransitionScheduleStatus.Inactive;
            bool hasSucceeded = matchState.MissionAttempt.Status == MissionAttemptStatus.Succeeded;
            int currentMissionNumber = matchState.MissionAttempt.MissionNumber;
            int destinationMissionNumber = currentMissionNumber;
            MissionTransitionAction transitionAction = MissionTransitionAction.RetryCurrentMission;
            if (hasSucceeded)
            {
                transitionAction = MissionTransitionAction.AdvanceToNextMission;
                destinationMissionNumber = MissionProgressionRules.AdvanceToNextMission(currentMissionNumber,
                    matchState.TargetMissionCount);
                if (destinationMissionNumber == currentMissionNumber)
                {
                    terminalStatus = MissionTransitionScheduleStatus.CampaignCompleted;
                }
                else if (!MissionAttemptPreparation.CanPrepareMission(destinationMissionNumber))
                {
                    terminalStatus = MissionTransitionScheduleStatus.MissionUnavailable;
                }
            }
            matchState.ConfigureMissionTransition(transitionAction, destinationMissionNumber);
            if (terminalStatus != MissionTransitionScheduleStatus.Inactive &&
                matchState.MissionTransitionStatus != terminalStatus)
            {
                matchState.SetMissionTransitionSchedule(terminalStatus, new MatchParticipantPresence
                {
                    MissingParticipantUserIds = Array.Empty<int>()
                }, 0);
            }
            return terminalStatus == MissionTransitionScheduleStatus.Inactive;
        }
    }
}
