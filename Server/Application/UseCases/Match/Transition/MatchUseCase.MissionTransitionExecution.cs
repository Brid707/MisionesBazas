using System;
using System.Security.Cryptography;
using System.Threading;
using Application.Models;
using Domain;

namespace Application.UseCases
{
    public sealed partial class MatchUseCase
    {
        private const string ScheduledTransitionFailureTemplate =
            "Automatic mission transition preparation failed. ExceptionType={ExceptionType}.";
        private const string ScheduledTransitionCompletedTemplate =
            "Match {MatchId} applied mission attempt {MissionAttemptId} automatically.";

        public MissionTransitionExecutionResult ExecuteScheduledMissionTransition(MissionTransitionWork transitionWork,
            CancellationToken cancellationToken)
        {
            MissionTransitionExecutionResult result;
            try
            {
                result = PrepareAndCommitScheduledTransition(transitionWork, cancellationToken);
            }
            catch (ArgumentException ex)
            {
                result = HandleScheduledTransitionFailure(transitionWork, ex);
            }
            catch (InvalidOperationException ex)
            {
                result = HandleScheduledTransitionFailure(transitionWork, ex);
            }
            catch (CryptographicException ex)
            {
                result = HandleScheduledTransitionFailure(transitionWork, ex);
            }
            return result;
        }

        private MissionTransitionExecutionResult PrepareAndCommitScheduledTransition(
            MissionTransitionWork transitionWork,
            CancellationToken cancellationToken)
        {
            MatchState matchState = _matchStateStore.FindMatch(transitionWork.LobbyCode);
            MatchPresenceQuery query = null;
            MissionAttemptPreparationContext preparationContext = null;
            if (matchState != null)
            {
                lock (matchState)
                {
                    if (IsCurrentTransitionReservation(matchState,
                        transitionWork) && !matchState.HasStartedTransitionExecution)
                    {
                        matchState.MarkTransitionExecutionStarted();
                        query = CreatePresenceQuery(transitionWork.LobbyCode, matchState);
                        preparationContext = new MissionAttemptPreparationContext
                        {
                            MissionNumber = transitionWork.DestinationMissionNumber,
                            MissionAttemptId = matchState.MissionAttempt.MissionAttemptId + 1,
                            AttemptNumber = GetDestinationAttemptNumber(matchState),
                            ParticipantUserIds = (int[])matchState.ParticipantUserIds.Clone()
                        };
                    }
                }
            }
            var result = new MissionTransitionExecutionResult { LobbyCode = transitionWork.LobbyCode };
            if (query != null && !cancellationToken.IsCancellationRequested &&
                _participantPresence.ConfirmPresence(query))
            {
                PreparedMissionAttempt preparedAttempt = MissionAttemptPreparation.Prepare(preparationContext,
                    _missionDeckDealer);
                result = CommitReservedTransition(transitionWork, preparedAttempt, cancellationToken);
            }
            else if (query != null)
            {
                result = ReleaseMissionTransitionReservation(transitionWork, false);
            }
            return result;
        }

        private MissionTransitionExecutionResult CommitReservedTransition(MissionTransitionWork transitionWork,
            PreparedMissionAttempt preparedAttempt, CancellationToken cancellationToken)
        {
            MatchState matchState = _matchStateStore.FindMatch(transitionWork.LobbyCode);
            bool hasCommitted = false;
            lock (matchState)
            {
                MatchParticipantPresence presence = _participantPresence.ReadPresence(
                    CreatePresenceQuery(transitionWork.LobbyCode, matchState));
                bool hasSameConnections = presence.ConnectionVersion == transitionWork.ConnectionVersion &&
                    presence.MissingParticipantUserIds.Length == 0;
                if (IsCurrentTransitionReservation(matchState, transitionWork) && hasSameConnections &&
                    !cancellationToken.IsCancellationRequested)
                {
                    matchState.CommitScheduledMissionTransition(preparedAttempt);
                    hasCommitted = true;
                }
            }
            MissionTransitionExecutionResult result = hasCommitted
                ? new MissionTransitionExecutionResult
                {
                    LobbyCode = transitionWork.LobbyCode,
                    HasStateChanged = true,
                    HasAppliedMissionTransition = true,
                    CommittedMatchStateVersion = matchState.MatchStateVersion
                }
                : ReleaseMissionTransitionReservation(transitionWork, false);
            if (hasCommitted)
            {
                _logger.Information(ScheduledTransitionCompletedTemplate, transitionWork.MatchId,
                    preparedAttempt.MissionAttempt.MissionAttemptId);
            }
            return result;
        }

        private MissionTransitionExecutionResult HandleScheduledTransitionFailure(
            MissionTransitionWork transitionWork, Exception ex)
        {
            _logger.Error(ScheduledTransitionFailureTemplate, ex.GetType().Name);
            return ReleaseMissionTransitionReservation(transitionWork, true);
        }

        public MissionTransitionExecutionResult ReleaseMissionTransitionReservation(
            MissionTransitionWork transitionWork,
            bool hasPreparationFailed)
        {
            var result = new MissionTransitionExecutionResult { LobbyCode = transitionWork.LobbyCode };
            MatchState matchState = _matchStateStore.FindMatch(transitionWork.LobbyCode);
            if (matchState != null)
            {
                lock (matchState)
                {
                    if (IsCurrentTransitionReservation(matchState, transitionWork))
                    {
                        MatchParticipantPresence presence = _participantPresence.ReadPresence(
                            CreatePresenceQuery(transitionWork.LobbyCode, matchState));
                        MissionTransitionScheduleStatus status = hasPreparationFailed
                            ? MissionTransitionScheduleStatus.PreparationFailed
                            : MissionTransitionScheduleStatus.CountingDown;
                        long deadline = _matchClock.GetTimestampMilliseconds() +
                            MissionTransitionPolicy.PreparationBackoffMilliseconds;
                        if (presence.MissingParticipantUserIds.Length > 0)
                        {
                            status = MissionTransitionScheduleStatus.WaitingForParticipants;
                            deadline = 0;
                        }
                        matchState.SetMissionTransitionSchedule(status, presence, deadline);
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

        private static int GetDestinationAttemptNumber(MatchState matchState)
        {
            return matchState.TransitionAction == MissionTransitionAction.AdvanceToNextMission
                ? MissionProgressionRules.InitialAttemptNumber
                : MissionProgressionRules.RestartAttempt(matchState.MissionAttempt.AttemptNumber);
        }

        private static bool IsCurrentTransitionReservation(MatchState matchState, MissionTransitionWork transitionWork)
        {
            return CanScheduleMissionTransition(matchState) && matchState.MatchId == transitionWork.MatchId &&
                matchState.MissionAttempt.MissionAttemptId == transitionWork.MissionAttemptId &&
                matchState.TransitionAction == transitionWork.TransitionAction &&
                matchState.DestinationMissionNumber == transitionWork.DestinationMissionNumber &&
                matchState.MissionTransitionScheduleId == transitionWork.MissionTransitionScheduleId &&
                matchState.MissionTransitionStatus == MissionTransitionScheduleStatus.Preparing;
        }
    }
}
