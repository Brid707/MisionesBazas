using System;
using Application.Models;
using Application.Ports;
using TrickTakingMissions.Rules.Rules;

namespace Application.UseCases
{
    /// <summary>Coordinates own-profile persistence through the existing profile repository port.</summary>
    public sealed class PlayerProfileUseCase : IPlayerProfileUseCase
    {
        private const string InvalidBiographyMessage = "Biography exceeds the supported capacity.";
        private readonly IPlayerProfileRepository _playerProfileRepository;

        public PlayerProfileUseCase(IPlayerProfileRepository playerProfileRepository)
        {
            _playerProfileRepository = playerProfileRepository;
        }

        public OwnPlayerProfile GetOwnProfile(int authenticatedAccountUserId)
        {
            return _playerProfileRepository.GetOwnProfile(authenticatedAccountUserId);
        }

        public string UpdateOwnBiography(int authenticatedAccountUserId, string biography)
        {
            if (!PlayerBiographyRules.IsBiographyValid(biography))
            {
                throw new ArgumentException(InvalidBiographyMessage, nameof(biography));
            }

            return _playerProfileRepository.UpdateBiography(authenticatedAccountUserId, biography);
        }
    }
}
