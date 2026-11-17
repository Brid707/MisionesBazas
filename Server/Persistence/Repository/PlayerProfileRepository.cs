using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Linq;
using Application.Models;
using Application.Ports;
using Persistence.Entities;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Persistence.Repository
{
    /// <summary>
    /// Maps generated image identifiers to the existing profile reference column.
    /// </summary>
    public sealed class PlayerProfileRepository : IPlayerProfileRepository
    {
        private const string ProfileImageFilePrefix = "Avatar_Profile_";
        private const string ProfileImageFileExtension = ".png";
        private const string GuidFormatN = "N";

        private const string ReadProfileMetadataEntityFailureTemplate =
            "Entity Framework connection failed while reading profile image metadata for {UserCount} user(s).";
        private const string ProfileOwnerNotFoundWarningTemplate =
            "Cannot replace profile image because authenticated user {UserId} does not exist.";
        private const string SaveProfileMetadataEntityFailureTemplate =
            "Entity Framework connection failed while saving profile image metadata for user {UserId}.";
        private const string SaveProfileMetadataDbUpdateFailureTemplate =
            "Database update failed while saving profile image metadata for user {UserId}.";

        private const string ReadProfileMetadataFailureMessage = "Profile image metadata could not be read.";
        private const string ProfileOwnerNotFoundMessage = "The profile owner does not exist.";
        private const string SaveProfileMetadataFailureMessage = "Profile image metadata could not be saved.";

        private readonly ILoggerService _logger;

        public PlayerProfileRepository(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public PlayerProfileImageData[] GetProfileImages(int[] profileOwnerUserIds)
        {
            PlayerProfileImageData[] profileImages;
            try
            {
                using (var context = new TrickTakingMissionsBDEntities())
                {
                    List<StoredProfileImageReference> storedProfiles = context.PlayerProfile.AsNoTracking()
                        .Where(profile => profileOwnerUserIds.Contains(profile.IdUser))
                        .Select(profile => new StoredProfileImageReference
                        {
                            IdUser = profile.IdUser,
                            AvatarPath = profile.AvatarPath
                        }).ToList();
                    profileImages = profileOwnerUserIds.Select(ownerId => new PlayerProfileImageData
                    {
                        ProfileOwnerUserId = ownerId,
                        ProfileImageId = ParseProfileImageId(storedProfiles
                            .FirstOrDefault(profile => profile.IdUser == ownerId)?.AvatarPath)
                    }).ToArray();
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, ReadProfileMetadataEntityFailureTemplate, profileOwnerUserIds != null ? profileOwnerUserIds.Length : 0);
                throw new InvalidOperationException(ReadProfileMetadataFailureMessage, ex);
            }
            return profileImages;
        }

        public Guid ReplaceProfileImage(int authenticatedAccountUserId, Guid profileImageId)
        {
            Guid previousImageId;
            try
            {
                using (var context = new TrickTakingMissionsBDEntities())
                {
                    PlayerProfile profile = context.PlayerProfile.Find(authenticatedAccountUserId);
                    if (profile == null)
                    {
                        User account = context.User.Find(authenticatedAccountUserId);
                        if (account == null)
                        {
                            _logger.Warning(ProfileOwnerNotFoundWarningTemplate, authenticatedAccountUserId);
                            throw new InvalidOperationException(ProfileOwnerNotFoundMessage);
                        }
                        profile = new PlayerProfile
                        {
                            IdUser = authenticatedAccountUserId,
                            DisplayName = account.Username,
                            CreatedAt = DateTime.UtcNow
                        };
                        context.PlayerProfile.Add(profile);
                    }
                    previousImageId = ParseProfileImageId(profile.AvatarPath);
                    profile.AvatarPath = ProfileImageFilePrefix + profileImageId.ToString(GuidFormatN) + ProfileImageFileExtension;
                    profile.UpdatedAt = DateTime.UtcNow;
                    context.SaveChanges();
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, SaveProfileMetadataEntityFailureTemplate, authenticatedAccountUserId);
                throw new InvalidOperationException(SaveProfileMetadataFailureMessage, ex);
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, SaveProfileMetadataDbUpdateFailureTemplate, authenticatedAccountUserId);
                throw new InvalidOperationException(SaveProfileMetadataFailureMessage, ex);
            }
            return previousImageId;
        }

        private static Guid ParseProfileImageId(string storedImageName)
        {
            Guid profileImageId = Guid.Empty;
            bool hasExpectedShape = storedImageName != null && storedImageName.StartsWith(ProfileImageFilePrefix,
                StringComparison.Ordinal) && storedImageName.EndsWith(ProfileImageFileExtension, StringComparison.Ordinal);
            if (hasExpectedShape)
            {
                string imageIdentifier = storedImageName.Substring(ProfileImageFilePrefix.Length,
                    storedImageName.Length - ProfileImageFilePrefix.Length - ProfileImageFileExtension.Length);
                Guid.TryParseExact(imageIdentifier, GuidFormatN, out profileImageId);
            }
            return profileImageId;
        }
        private sealed class StoredProfileImageReference
        {
            public int IdUser { get; set; }
            public string AvatarPath { get; set; }
        }
    }
}
