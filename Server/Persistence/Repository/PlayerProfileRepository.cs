using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Linq;
using Application.Models;
using Application.Ports;
using Persistence.Entities;

namespace Persistence.Repository
{
    /// <summary>
    /// Maps generated image identifiers to the existing profile reference column.
    /// </summary>
    public sealed class PlayerProfileRepository : IPlayerProfileRepository
    {
        private const string ProfileImageFilePrefix = "Avatar_Profile_";

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
                throw new InvalidOperationException("Profile image metadata could not be read.", ex);
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
                            throw new InvalidOperationException("The profile owner does not exist.");
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
                    profile.AvatarPath = ProfileImageFilePrefix + profileImageId.ToString("N") + ".png";
                    profile.UpdatedAt = DateTime.UtcNow;
                    context.SaveChanges();
                }
            }
            catch (EntityException ex)
            {
                throw new InvalidOperationException("Profile image metadata could not be saved.", ex);
            }
            catch (DbUpdateException ex)
            {
                throw new InvalidOperationException("Profile image metadata could not be saved.", ex);
            }
            return previousImageId;
        }

        private static Guid ParseProfileImageId(string storedImageName)
        {
            Guid profileImageId = Guid.Empty;
            bool hasExpectedShape = storedImageName != null && storedImageName.StartsWith(ProfileImageFilePrefix,
                StringComparison.Ordinal) && storedImageName.EndsWith(".png", StringComparison.Ordinal);
            if (hasExpectedShape)
            {
                string imageIdentifier = storedImageName.Substring(ProfileImageFilePrefix.Length,
                    storedImageName.Length - ProfileImageFilePrefix.Length - 4);
                Guid.TryParseExact(imageIdentifier, "N", out profileImageId);
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
