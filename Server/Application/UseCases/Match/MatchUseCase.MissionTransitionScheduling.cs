using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using Domain;
using TrickTakingMissions.Rules.Enums;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        public IReadOnlyList<MissionTransitionWork> TakeDueMissionTransitions(int maximumPreparations)
        {
            var dueTransitions = new List<MissionTransitionWork>();
            int preparationLimit = Math.Min(Math.Max(maximumPreparations, 0),
                MissionTransitionPolicy.MaximumConcurrentPreparations);
            foreach (KeyValuePair<string, MatchState> storedMatch in _matchStateStore.GetMatches())
            {
                lock (storedMatch.Value)
                {
                    MissionTransitionWork transitionWork = RefreshMissionTransitionSchedule(storedMatch,
                        dueTransitions.Count < preparationLimit);
                    if (transitionWork != null)
                    {
                        dueTransitions.Add(transitionWork);
                    }
                }
            }
            return dueTransitions;
        }

        private MissionTransitionWork RefreshMissionTransitionSchedule(KeyValuePair<string, MatchState> storedMatch,
            bool canPrepare)
        {
            MatchState matchState = storedMatch.Value;
            MissionTransitionWork transitionWork = null;
            if (CanScheduleMissionTransition(matchState) && ResolveMissionTransition(matchState))
            {
                MatchPresenceQuery query = CreatePresenceQuery(storedMatch.Key, matchState);
                MatchParticipantPresence presence = _participantPresence.ReadPresence(query);
                RefreshTransitionConnectivity(matchState, presence);
                bool isCountdownDue =
                    (matchState.MissionTransitionStatus == MissionTransitionScheduleStatus.CountingDown ||
                    matchState.MissionTransitionStatus == MissionTransitionScheduleStatus.PreparationFailed) &&
                    _matchClock.GetTimestampMilliseconds() >= matchState.MissionTransitionDeadlineMilliseconds;
                if (isCountdownDue && canPrepare)
                {
                    matchState.ReserveMissionTransitionPreparation();
                    transitionWork = new MissionTransitionWork
                    {
                        LobbyCode = storedMatch.Key,
                        MatchId = matchState.MatchId,
                        MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                        MissionTransitionScheduleId = matchState.MissionTransitionScheduleId,
                        TransitionAction = matchState.TransitionAction,
                        DestinationMissionNumber = matchState.DestinationMissionNumber,
                        ConnectionVersion = presence.ConnectionVersion
                    };
                }
            }
            return transitionWork;
        }

        private static bool CanScheduleMissionTransition(MatchState matchState)
        {
            return matchState.MissionAttempt.Phase == MissionAttemptPhase.Finished &&
                (matchState.MissionAttempt.Status == MissionAttemptStatus.Failed ||
                    matchState.MissionAttempt.Status == MissionAttemptStatus.Succeeded);
        }

        private void RefreshTransitionConnectivity(MatchState matchState, MatchParticipantPresence presence)
        {
            if (presence.MissingParticipantUserIds.Length > 0)
            {
                bool hasPresenceChanged =
                    matchState.MissionTransitionStatus != MissionTransitionScheduleStatus.WaitingForParticipants ||
                    matchState.MissionTransitionConnectionVersion != presence.ConnectionVersion ||
                    !matchState.MissingTransitionParticipantUserIds.SequenceEqual(presence.MissingParticipantUserIds);
                if (hasPresenceChanged)
                {
                    matchState.SetMissionTransitionSchedule(MissionTransitionScheduleStatus.WaitingForParticipants,
                        presence, 0);
                }
            }
            else
            {
                RefreshConnectedTransition(matchState, presence);
            }
        }

        private void RefreshConnectedTransition(MatchState matchState, MatchParticipantPresence presence)
        {
            bool hasAttemptCapacity = matchState.MissionAttempt.MissionAttemptId < int.MaxValue &&
                (matchState.TransitionAction == MissionTransitionAction.AdvanceToNextMission ||
                    matchState.MissionAttempt.AttemptNumber < int.MaxValue);
            if (!hasAttemptCapacity)
            {
                if (matchState.MissionTransitionStatus != MissionTransitionScheduleStatus.AttemptLimitReached)
                {
                    matchState.SetMissionTransitionSchedule(MissionTransitionScheduleStatus.AttemptLimitReached,
                        presence, 0);
                }
            }
            else if (matchState.MissionTransitionStatus == MissionTransitionScheduleStatus.Inactive ||
                matchState.MissionTransitionStatus == MissionTransitionScheduleStatus.WaitingForParticipants ||
                matchState.MissionTransitionConnectionVersion != presence.ConnectionVersion)
            {
                matchState.SetMissionTransitionSchedule(MissionTransitionScheduleStatus.CountingDown, presence,
                    _matchClock.GetTimestampMilliseconds() + MissionTransitionPolicy.CountdownMilliseconds);
            }
        }

        private static MatchPresenceQuery CreatePresenceQuery(string lobbyCode, MatchState matchState)
        {
            return new MatchPresenceQuery
            {
                LobbyCode = lobbyCode,
                MatchId = matchState.MatchId,
                MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                ParticipantUserIds = (int[])matchState.ParticipantUserIds.Clone(),
                ExpectedConnectionVersion = matchState.MissionTransitionConnectionVersion
            };
        }
    }
}
