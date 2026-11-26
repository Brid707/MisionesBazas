using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DataContracts;
using TrickTakingMissions.Rules.Rules;

namespace Services.Services
{
    /// <summary>Authorizes own-profile requests and translates persistence failures into declared WCF faults.</summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class PlayerProfileService : IPlayerProfileService
    {
        private const int MaximumAccountSessionTokenLength = 256;
        private const string ProfileFaultMessage = "Profile operation could not be completed.";
        private readonly IPlayerProfileUseCase _playerProfileUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;

        public PlayerProfileService(IPlayerProfileUseCase playerProfileUseCase,
            IAccountAccessPolicy accountAccessPolicy)
        {
            _playerProfileUseCase = playerProfileUseCase;
            _accountAccessPolicy = accountAccessPolicy;
        }

        public PlayerProfileDetails GetOwnProfile(string accountSessionToken)
        {
            return ExecuteProfileOperation(accountSessionToken, ReadOwnProfile);
        }

        public string UpdateOwnBiography(ProfileBiographyUpdate biographyUpdate)
        {
            if (biographyUpdate == null || !PlayerBiographyRules.IsBiographyValid(biographyUpdate.Biography))
            {
                throw CreateFault(PlayerProfileFailureReason.InvalidBiography);
            }
            return ExecuteProfileOperation(biographyUpdate.AccountSessionToken,
                accountUserId => SaveOwnBiography(accountUserId, biographyUpdate.Biography));
        }

        private T ExecuteProfileOperation<T>(string accountSessionToken, Func<int, T> profileOperation)
        {
            T operationResult;
            try
            {
                int accountUserId = ResolveAccountUserId(accountSessionToken);
                operationResult = profileOperation(accountUserId);
            }
            catch (PlayerProfileUnavailableException)
            {
                throw CreateFault(PlayerProfileFailureReason.ProfileUnavailable);
            }
            catch (InvalidOperationException)
            {
                // Account-access persistence already records its database failure.
                throw CreateFault(PlayerProfileFailureReason.ProfileUnavailable);
            }
            return operationResult;
        }

        private PlayerProfileDetails ReadOwnProfile(int accountUserId)
        {
            OwnPlayerProfile ownProfile = _playerProfileUseCase.GetOwnProfile(accountUserId);
            if (ownProfile == null)
            {
                throw CreateFault(PlayerProfileFailureReason.ProfileNotFound);
            }
            return new PlayerProfileDetails
            {
                Username = ownProfile.Username,
                Email = ownProfile.Email,
                AccountCreatedAtUtc = ownProfile.AccountCreatedAtUtc,
                Biography = ownProfile.Biography,
                CompletedMissionCount = ownProfile.CompletedMissionCount
            };
        }

        private string SaveOwnBiography(int accountUserId, string biography)
        {
            string savedBiography = _playerProfileUseCase.UpdateOwnBiography(accountUserId, biography);
            if (savedBiography == null)
            {
                throw CreateFault(PlayerProfileFailureReason.ProfileNotFound);
            }
            return savedBiography;
        }

        private int ResolveAccountUserId(string accountSessionToken)
        {
            if (string.IsNullOrWhiteSpace(accountSessionToken) ||
                accountSessionToken.Length > MaximumAccountSessionTokenLength)
            {
                throw CreateFault(PlayerProfileFailureReason.AccessDenied);
            }
            int accountUserId = _accountAccessPolicy.ResolveAllowedAccountUserId(accountSessionToken);
            if (accountUserId <= 0)
            {
                throw CreateFault(PlayerProfileFailureReason.AccessDenied);
            }
            return accountUserId;
        }

        private static FaultException<PlayerProfileFault> CreateFault(PlayerProfileFailureReason failureReason)
        {
            return new FaultException<PlayerProfileFault>(new PlayerProfileFault { FailureReason = failureReason },
                new FaultReason(ProfileFaultMessage));
        }
    }
}
