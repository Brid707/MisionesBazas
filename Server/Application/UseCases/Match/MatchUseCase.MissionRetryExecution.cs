using System;
using System.Security.Cryptography;
using System.Threading;
using Application.Models;
using Domain;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private const string ScheduledRetryFailureTemplate =
            "Automatic mission retry preparation failed. ExceptionType={ExceptionType}.";
        private const string ScheduledRetryCompletedTemplate =
            "Match {MatchId} restarted mission attempt {MissionAttemptId} automatically.";

        public MissionRetryExecutionResult ExecuteScheduledMissionRetry(MissionRetryWork retryWork,
            CancellationToken cancellationToken)
        {
            MissionRetryExecutionResult result;
            try
            {
                result = PrepareAndCommitScheduledRetry(retryWork, cancellationToken);
            }
            catch (ArgumentException ex)
            {
                result = HandleScheduledRetryFailure(retryWork, ex);
            }
            catch (InvalidOperationException ex)
            {
                result = HandleScheduledRetryFailure(retryWork, ex);
            }
            catch (CryptographicException ex)
            {
                result = HandleScheduledRetryFailure(retryWork, ex);
            }
            return result;
        }

        private MissionRetryExecutionResult PrepareAndCommitScheduledRetry(MissionRetryWork retryWork,
            CancellationToken cancellationToken)
        {
            MatchState matchState = _matchStateStore.FindMatch(retryWork.LobbyCode);
            MatchPresenceQuery query = null;
            MissionAttemptPreparationContext preparationContext = null;
            if (matchState != null)
            {
                lock (matchState)
                {
                    if (IsCurrentRetryReservation(matchState, retryWork) && !matchState.HasStartedRetryExecution)
                    {
                        matchState.MarkRetryExecutionStarted();
                        query = CreatePresenceQuery(retryWork.LobbyCode, matchState);
                        preparationContext = new MissionAttemptPreparationContext
                        {
                            MissionNumber = matchState.MissionAttempt.MissionNumber,
                            MissionAttemptId = matchState.MissionAttempt.MissionAttemptId + 1,
                            AttemptNumber = MissionProgressionRules.RestartAttempt(
                                matchState.MissionAttempt.AttemptNumber),
                            ParticipantUserIds = (int[])matchState.ParticipantUserIds.Clone()
                        };
                    }
                }
            }
            var result = new MissionRetryExecutionResult { LobbyCode = retryWork.LobbyCode };
            if (query != null && !cancellationToken.IsCancellationRequested &&
                _participantPresence.ConfirmPresence(query))
            {
                PreparedMissionAttempt preparedAttempt = MissionAttemptPreparation.Prepare(preparationContext,
                    _missionDeckDealer);
                result = CommitReservedRetry(retryWork, preparedAttempt, cancellationToken);
            }
            else if (query != null)
            {
                result = ReleaseMissionRetryReservation(retryWork, false);
            }
            return result;
        }

        private MissionRetryExecutionResult CommitReservedRetry(MissionRetryWork retryWork,
            PreparedMissionAttempt preparedAttempt, CancellationToken cancellationToken)
        {
            MatchState matchState = _matchStateStore.FindMatch(retryWork.LobbyCode);
            bool hasCommitted = false;
            lock (matchState)
            {
                MatchParticipantPresence presence = _participantPresence.ReadPresence(
                    CreatePresenceQuery(retryWork.LobbyCode, matchState));
                bool hasSameConnections = presence.ConnectionVersion == retryWork.ConnectionVersion &&
                    presence.MissingParticipantUserIds.Length == 0;
                if (IsCurrentRetryReservation(matchState, retryWork) && hasSameConnections &&
                    !cancellationToken.IsCancellationRequested)
                {
                    matchState.CommitScheduledMissionRetry(preparedAttempt);
                    hasCommitted = true;
                }
            }
            MissionRetryExecutionResult result = hasCommitted
                ? new MissionRetryExecutionResult
                {
                    LobbyCode = retryWork.LobbyCode,
                    HasStateChanged = true,
                    HasRestartedMission = true,
                    CommittedMatchStateVersion = matchState.MatchStateVersion
                }
                : ReleaseMissionRetryReservation(retryWork, false);
            if (hasCommitted)
            {
                _logger.Information(ScheduledRetryCompletedTemplate, retryWork.MatchId,
                    preparedAttempt.MissionAttempt.MissionAttemptId);
            }
            return result;
        }

        private MissionRetryExecutionResult HandleScheduledRetryFailure(MissionRetryWork retryWork, Exception ex)
        {
            _logger.Error(ScheduledRetryFailureTemplate, ex.GetType().Name);
            return ReleaseMissionRetryReservation(retryWork, true);
        }

        public MissionRetryExecutionResult ReleaseMissionRetryReservation(MissionRetryWork retryWork,
            bool hasPreparationFailed)
        {
            var result = new MissionRetryExecutionResult { LobbyCode = retryWork.LobbyCode };
            MatchState matchState = _matchStateStore.FindMatch(retryWork.LobbyCode);
            if (matchState != null)
            {
                lock (matchState)
                {
                    if (IsCurrentRetryReservation(matchState, retryWork))
                    {
                        MatchParticipantPresence presence = _participantPresence.ReadPresence(
                            CreatePresenceQuery(retryWork.LobbyCode, matchState));
                        MissionRetryScheduleStatus status = hasPreparationFailed
                            ? MissionRetryScheduleStatus.PreparationFailed : MissionRetryScheduleStatus.CountingDown;
                        long deadline = _matchClock.GetTimestampMilliseconds() +
                            MissionRetryPolicy.PreparationBackoffMilliseconds;
                        if (presence.MissingParticipantUserIds.Length > 0)
                        {
                            status = MissionRetryScheduleStatus.WaitingForParticipants;
                            deadline = 0;
                        }
                        matchState.SetMissionRetrySchedule(status, presence, deadline);
                        result = result with
                        {
                            HasStateChanged = true,
                            CommittedMatchStateVersion = matchState.MatchStateVersion
                        };
                    }
                }
            }
            return result;
        }

        private static bool IsCurrentRetryReservation(MatchState matchState, MissionRetryWork retryWork)
        {
            return CanScheduleMissionRetry(matchState) && matchState.MatchId == retryWork.MatchId &&
                matchState.MissionAttempt.MissionAttemptId == retryWork.MissionAttemptId &&
                matchState.MissionRetryScheduleId == retryWork.MissionRetryScheduleId &&
                matchState.MissionRetryStatus == MissionRetryScheduleStatus.Preparing;
        }
    }
}
