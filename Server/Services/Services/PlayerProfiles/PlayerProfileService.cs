using System;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.DataContracts;
using TrickTakingMissions.Rules.Rules;

namespace Services.Services
{
    /// <summary>Authorizes profile operations and translates persistence failures into declared WCF faults.</summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public sealed class PlayerProfileService : IPlayerProfileService
    {
        private const int MaximumProfileLobbyCodeLength = 16;
        private const int MaximumAccountSessionTokenLength = 256;
        private const string ProfileFaultMessage = "Profile operation could not be completed.";
        private readonly IPlayerProfileUseCase _playerProfileUseCase;
        private readonly IAccountAccessPolicy _accountAccessPolicy;
        private readonly IGuestLobbyProfileAccess _guestLobbyProfileAccess;

        public PlayerProfileService(IPlayerProfileUseCase playerProfileUseCase,
            IAccountAccessPolicy accountAccessPolicy, IGuestLobbyProfileAccess guestLobbyProfileAccess)
        {
            _playerProfileUseCase = playerProfileUseCase;
            _accountAccessPolicy = accountAccessPolicy;
            _guestLobbyProfileAccess = guestLobbyProfileAccess;
        }

        public PlayerProfileDetails GetOwnProfile(string accountSessionToken)
        {
            return ExecuteProfileOperation(accountSessionToken, ReadOwnProfile);
        }

        public PublicPlayerProfileDetails GetPublicProfile(PublicPlayerProfileLookup profileLookup)
        {
            ValidatePublicLookup(profileLookup);
            return ExecuteProfileBoundary(() => ReadAuthorizedPublicProfile(profileLookup));
        }

        private PublicPlayerProfileDetails ReadAuthorizedPublicProfile(PublicPlayerProfileLookup profileLookup)
        {
            if (!string.IsNullOrEmpty(profileLookup.AccountSessionToken))
            {
                ResolveAccountUserId(profileLookup.AccountSessionToken);
            }
            else
            {
                EnsureGuestProfileAllowed(profileLookup);
            }
            PublicPlayerProfile profile = _playerProfileUseCase.GetPublicProfile(profileLookup.ProfileOwnerUserId,
                profileLookup.ProfileOwnerUsername);
            if (profile == null)
            {
                throw CreateFault(PlayerProfileFailureReason.ProfileNotFound);
            }
            return new PublicPlayerProfileDetails
            {
                ProfileOwnerUserId = profile.ProfileOwnerUserId,
                Username = profile.Username,
                Biography = profile.Biography,
                AccountCreatedAtUtc = profile.AccountCreatedAtUtc,
                CompletedMissionCount = profile.CompletedMissionCount
            };
        }

        private static void ValidatePublicLookup(PublicPlayerProfileLookup profileLookup)
        {
            if (profileLookup == null || !PlayerProfileLookupRules.IsProfileLookupValid(
                profileLookup.ProfileOwnerUserId, profileLookup.ProfileOwnerUsername))
            {
                throw CreateFault(PlayerProfileFailureReason.ProfileNotFound);
            }
        }

        private void EnsureGuestProfileAllowed(PublicPlayerProfileLookup profileLookup)
        {
            bool hasGuestContext = profileLookup.GuestViewerUserId < 0 && profileLookup.ProfileOwnerUserId > 0 &&
                string.IsNullOrEmpty(profileLookup.ProfileOwnerUsername) &&
                !string.IsNullOrEmpty(profileLookup.GuestSessionToken) &&
                profileLookup.GuestSessionToken.Length <= MaximumAccountSessionTokenLength &&
                !string.IsNullOrWhiteSpace(profileLookup.LobbyCode) &&
                profileLookup.LobbyCode.Length <= MaximumProfileLobbyCodeLength;
            if (!hasGuestContext || !_guestLobbyProfileAccess.CanViewProfile(new GuestLobbyProfileAccessRequest
            {
                GuestViewerUserId = profileLookup.GuestViewerUserId,
                GuestSessionToken = profileLookup.GuestSessionToken,
                LobbyCode = profileLookup.LobbyCode,
                ProfileOwnerUserId = profileLookup.ProfileOwnerUserId
            }))
            {
                throw CreateFault(PlayerProfileFailureReason.AccessDenied);
            }
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
            return ExecuteProfileBoundary(() => profileOperation(ResolveAccountUserId(accountSessionToken)));
        }

        private static T ExecuteProfileBoundary<T>(Func<T> profileOperation)
        {
            T operationResult;
            try
            {
                operationResult = profileOperation();
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
