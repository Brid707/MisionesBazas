using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.DataContracts;
using Services.Mapping;
using ContractBlindResponse = Services.DataContracts.BlindObjectiveResponse;

namespace Services.Services
{
    public sealed class LobbySpecialPreparationService
    {
        private const int MaximumMatchActionLobbyCodeLength = 16;

        private readonly ILobbyUseCase _lobbyUseCase;
        private readonly Action<string, long> _broadcastMatchStateChanged;
        private readonly Action _ensureSessionBudget;
        private readonly Action<string, int> _ensureParticipantAllowed;

        public LobbySpecialPreparationService(
            ILobbyUseCase lobbyUseCase,
            Action<string, long> broadcastMatchStateChanged,
            Action ensureSessionBudget,
            Action<string, int> ensureParticipantAllowed)
        {
            _lobbyUseCase = lobbyUseCase ?? throw new ArgumentNullException(nameof(lobbyUseCase));
            _broadcastMatchStateChanged = broadcastMatchStateChanged ?? throw new ArgumentNullException(nameof(broadcastMatchStateChanged));
            _ensureSessionBudget = ensureSessionBudget ?? throw new ArgumentNullException(nameof(ensureSessionBudget));
            _ensureParticipantAllowed = ensureParticipantAllowed ?? throw new ArgumentNullException(nameof(ensureParticipantAllowed));
        }

        public MissionPreparationConfirmation IdentifyHeartNineOwner(
            HeartNineIdentificationSubmission submission, int participantUserId)
        {
            if (submission == null)
            {
                throw CreatePreparationFault(MissionPreparationFailureReason.InvalidSubmission);
            }
            return CommitMissionPreparation(MissionPreparationMapper.MapSubmission(submission), participantUserId);
        }

        public MissionPreparationConfirmation AssignMissionTrickDistribution(
            MissionTrickDistributionSubmission submission, int participantUserId)
        {
            if (submission == null)
            {
                throw CreatePreparationFault(MissionPreparationFailureReason.InvalidSubmission);
            }
            return CommitMissionPreparation(MissionPreparationMapper.MapSubmission(submission), participantUserId);
        }

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
            if (submission == null || (submission.Response != ContractBlindResponse.Yes &&
                submission.Response != ContractBlindResponse.No))
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

            _ensureSessionBudget();
            _ensureParticipantAllowed(request.LobbyCode, participantUserId);

            MissionPreparationCommit commit = ExecuteMissionPreparation(request, participantUserId);
            if (commit.Rejection != MissionPreparationRejection.None)
            {
                throw CreatePreparationFault(MissionPreparationMapper.MapRejection(commit.Rejection));
            }

            if (commit.HasStateChanged)
            {
                _broadcastMatchStateChanged(request.LobbyCode, commit.CommittedMatchStateVersion);
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
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(MissionPreparationFailureReason.OperationUnavailable)
                }, new FaultReason(ex.Message));
            }
            catch (InvalidOperationException ex)
            {
                throw new FaultException<MatchAccessFault>(new MatchAccessFault
                {
                    FailureCode = nameof(MissionPreparationFailureReason.OperationUnavailable)
                }, new FaultReason(ex.Message));
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
