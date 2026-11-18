using System;
using System.Collections.Generic;
using System.Linq;
using Application.Models;
using TrickTakingMissions.Rules.Enums;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        public IReadOnlyList<MissionRetryWork> TakeDueMissionRetries(int maximumPreparations)
        {
            var dueRetries = new List<MissionRetryWork>();
            int preparationLimit = Math.Min(Math.Max(maximumPreparations, 0),
                MissionRetryPolicy.MaximumConcurrentPreparations);
            foreach (KeyValuePair<string, MatchState> storedMatch in _matchStateStore.GetMatches())
            {
                lock (storedMatch.Value)
                {
                    MissionRetryWork retryWork = RefreshMissionRetrySchedule(storedMatch,
                        dueRetries.Count < preparationLimit);
                    if (retryWork != null)
                    {
                        dueRetries.Add(retryWork);
                    }
                }
            }
            return dueRetries;
        }

        private MissionRetryWork RefreshMissionRetrySchedule(KeyValuePair<string, MatchState> storedMatch,
            bool canPrepare)
        {
            MatchState matchState = storedMatch.Value;
            MissionRetryWork retryWork = null;
            if (CanScheduleMissionRetry(matchState))
            {
                MatchPresenceQuery query = CreatePresenceQuery(storedMatch.Key, matchState);
                MatchParticipantPresence presence = _participantPresence.ReadPresence(query);
                RefreshRetryConnectivity(matchState, presence);
                bool isCountdownDue = (matchState.MissionRetryStatus == MissionRetryScheduleStatus.CountingDown ||
                    matchState.MissionRetryStatus == MissionRetryScheduleStatus.PreparationFailed) &&
                    _matchClock.GetTimestampMilliseconds() >= matchState.MissionRetryDeadlineMilliseconds;
                if (isCountdownDue && canPrepare)
                {
                    matchState.ReserveMissionRetryPreparation();
                    retryWork = new MissionRetryWork
                    {
                        LobbyCode = storedMatch.Key,
                        MatchId = matchState.MatchId,
                        MissionAttemptId = matchState.MissionAttempt.MissionAttemptId,
                        MissionRetryScheduleId = matchState.MissionRetryScheduleId,
                        ConnectionVersion = presence.ConnectionVersion
                    };
                }
            }
            return retryWork;
        }

        private static bool CanScheduleMissionRetry(MatchState matchState)
        {
            return matchState.MissionAttempt.Phase == MissionAttemptPhase.Finished &&
                matchState.MissionAttempt.Status == MissionAttemptStatus.Failed;
        }

        private void RefreshRetryConnectivity(MatchState matchState, MatchParticipantPresence presence)
        {
            if (presence.MissingParticipantUserIds.Length > 0)
            {
                bool hasPresenceChanged =
                    matchState.MissionRetryStatus != MissionRetryScheduleStatus.WaitingForParticipants ||
                    matchState.MissionRetryConnectionVersion != presence.ConnectionVersion ||
                    !matchState.MissingRetryParticipantUserIds.SequenceEqual(presence.MissingParticipantUserIds);
                if (hasPresenceChanged)
                {
                    matchState.SetMissionRetrySchedule(MissionRetryScheduleStatus.WaitingForParticipants, presence, 0);
                }
            }
            else
            {
                RefreshConnectedRetry(matchState, presence);
            }
        }

        private void RefreshConnectedRetry(MatchState matchState, MatchParticipantPresence presence)
        {
            bool hasAttemptCapacity = matchState.MissionAttempt.MissionAttemptId < int.MaxValue &&
                matchState.MissionAttempt.AttemptNumber < int.MaxValue;
            if (!hasAttemptCapacity)
            {
                if (matchState.MissionRetryStatus != MissionRetryScheduleStatus.AttemptLimitReached)
                {
                    matchState.SetMissionRetrySchedule(MissionRetryScheduleStatus.AttemptLimitReached, presence, 0);
                }
            }
            else if (matchState.MissionRetryStatus == MissionRetryScheduleStatus.Inactive ||
                matchState.MissionRetryStatus == MissionRetryScheduleStatus.WaitingForParticipants ||
                matchState.MissionRetryConnectionVersion != presence.ConnectionVersion)
            {
                matchState.SetMissionRetrySchedule(MissionRetryScheduleStatus.CountingDown, presence,
                    _matchClock.GetTimestampMilliseconds() + MissionRetryPolicy.CountdownMilliseconds);
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
                ExpectedConnectionVersion = matchState.MissionRetryConnectionVersion
            };
        }
    }
}
