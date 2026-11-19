using System;
using System.ServiceModel;
using Application.Models;
using Gameplay;
using Services.Mapping;

namespace Services.Services
{
    public sealed partial class LobbyService
    {
        public MissionPreparationConfirmation AssignMissionRole(MissionRoleAssignmentSubmission submission,
            int participantUserId)
        {
            if (submission == null)
            {
                throw CreatePreparationFault(MissionPreparationFailureReason.InvalidSubmission);
            }
            return CommitMissionPreparation(MissionPreparationMapper.MapSubmission(submission), participantUserId);
        }

        public MissionPreparationConfirmation RespondToBlindObjectives(BlindObjectiveResponseSubmission submission,
            int participantUserId)
        {
            if (submission == null || (submission.Response != BlindObjectiveResponse.Yes &&
                submission.Response != BlindObjectiveResponse.No))
            {
                throw CreatePreparationFault(MissionPreparationFailureReason.InvalidSubmission);
            }
            return CommitMissionPreparation(MissionPreparationMapper.MapSubmission(submission), participantUserId);
        }

        private MissionPreparationConfirmation CommitMissionPreparation(MissionPreparationRequest request,
            int participantUserId)
        {
            if (string.IsNullOrWhiteSpace(request.LobbyCode) ||
                request.LobbyCode.Length > MaximumMatchActionLobbyCodeLength)
            {
                throw CreatePreparationFault(MissionPreparationFailureReason.InvalidSubmission);
            }
            EnsureMatchActionSessionBudget();
            EnsureMatchParticipantAllowed(request.LobbyCode, participantUserId);
            MissionPreparationCommit commit = ExecuteMissionPreparation(request, participantUserId);
            if (commit.Rejection != MissionPreparationRejection.None)
            {
                throw CreatePreparationFault(MissionPreparationMapper.MapRejection(commit.Rejection));
            }
            if (commit.HasStateChanged)
            {
                BroadcastToRoom(request.LobbyCode, null,
                    callback => callback.OnMatchStateChanged(commit.CommittedMatchStateVersion));
            }
            return new MissionPreparationConfirmation
            {
                MissionPreparationSubmissionId = commit.MissionPreparationSubmissionId,
                CommittedMatchStateVersion = commit.CommittedMatchStateVersion
            };
        }

        private MissionPreparationCommit ExecuteMissionPreparation(MissionPreparationRequest request,
            int participantUserId)
        {
            MissionPreparationCommit commit;
            try
            {
                commit = _lobbyUseCase.Match.ProcessMissionPreparation(request, participantUserId);
            }
            catch (ArgumentException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(MissionPreparationFailureReason.OperationUnavailable));
            }
            catch (InvalidOperationException ex)
            {
                throw CreateMatchOperationFault(ex, nameof(MissionPreparationFailureReason.OperationUnavailable));
            }
            return commit;
        }

        private static FaultException<MissionPreparationFault>
            CreatePreparationFault(MissionPreparationFailureReason reason)
        {
            return new FaultException<MissionPreparationFault>(new MissionPreparationFault { FailureReason = reason });
        }
    }
}
