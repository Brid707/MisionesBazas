using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using ProfileImages;
using Services.DataContracts;

namespace Model.Services
{
    /// <summary>
    /// Bounds and reuses profile image downloads while recovering missed server notifications.
    /// </summary>
    public sealed class ProfileImageCache : IProfileImageCache
    {
        private const int MaximumCachedPlayers = ProfileImageLimits.MaximumRequestedPlayers;
        private readonly IProfileImageClient _profileImageClient;
        private readonly object _entryLock = new object();
        private readonly SemaphoreSlim _refreshGate = new SemaphoreSlim(1, 1);
        private readonly Dictionary<int, ProfileImageCacheEntry> _entries =
            new Dictionary<int, ProfileImageCacheEntry>();
        private readonly Timer _refreshTimer;
        private int _isRefreshScheduled;
        private bool _isDisposed;

        public ProfileImageCache(IProfileImageClient profileImageClient)
        {
            _profileImageClient = profileImageClient;
            _profileImageClient.ProfileImageChanged += OnServerImageChanged;
            _refreshTimer = new Timer(_ => ScheduleRefresh(), null, TimeSpan.FromSeconds(30), TimeSpan.FromSeconds(30));
        }

        public event Action<int> ProfileImageChanged;

        public void RegisterPlayer(int profileOwnerUserId)
        {
            if (profileOwnerUserId > 0)
            {
                lock (_entryLock)
                {
                    EnsureCacheEntry(profileOwnerUserId).ReferenceCount++;
                }
            }
        }

        private ProfileImageCacheEntry EnsureCacheEntry(int ownerId)
        {
            if (!_entries.TryGetValue(ownerId, out ProfileImageCacheEntry entry))
            {
                if (_entries.Count >= MaximumCachedPlayers)
                {
                    int unusedOwnerId = _entries.FirstOrDefault(pair => pair.Value.ReferenceCount == 0).Key;
                    if (unusedOwnerId == 0)
                    {
                        throw new ProfileImageOperationException(ProfileImageFailureCodes.ImageServiceBusy);
                    }
                    _entries.Remove(unusedOwnerId);
                }
                entry = new ProfileImageCacheEntry();
                _entries.Add(ownerId, entry);
            }
            return entry;
        }

        public void UnregisterPlayer(int profileOwnerUserId)
        {
            lock (_entryLock)
            {
                if (_entries.TryGetValue(profileOwnerUserId, out ProfileImageCacheEntry entry))
                {
                    entry.ReferenceCount = Math.Max(0, entry.ReferenceCount - 1);
                }
            }
        }

        public async Task<byte[]> LoadProfileImageAsync(int profileOwnerUserId)
        {
            byte[] imageBytes = null;
            if (profileOwnerUserId > 0 && !_isDisposed)
            {
                await _refreshGate.WaitAsync().ConfigureAwait(false);
                try
                {
                    bool needsRefresh;
                    lock (_entryLock)
                    {
                        needsRefresh = EnsureCacheEntry(profileOwnerUserId).LastValidatedAtUtc <
                            DateTime.UtcNow.AddMinutes(-1);
                    }
                    if (needsRefresh)
                    {
                        await RefreshActiveImagesAsync(profileOwnerUserId).ConfigureAwait(false);
                    }
                    lock (_entryLock)
                    {
                        imageBytes = EnsureCacheEntry(profileOwnerUserId).ImageBytes;
                    }
                }
                finally
                {
                    _refreshGate.Release();
                }
            }
            return imageBytes;
        }

        public async Task ChangeOwnProfileImageAsync(byte[] selectedProfileImageBytes)
        {
            await _refreshGate.WaitAsync().ConfigureAwait(false);
            try
            {
                PlayerProfileImageReference changedImage =
                    await _profileImageClient.ChangeOwnProfileImageAsync(selectedProfileImageBytes)
                        .ConfigureAwait(false);
                lock (_entryLock)
                {
                    EnsureCacheEntry(changedImage.ProfileOwnerUserId).LastValidatedAtUtc = DateTime.MinValue;
                }
                try
                {
                    await RefreshActiveImagesAsync(changedImage.ProfileOwnerUserId).ConfigureAwait(false);
                }
                catch (ProfileImageOperationException ex)
                {
                    Trace.TraceWarning("Uploaded profile image display refresh deferred: {0}", ex.FailureCode);
                }
            }
            finally
            {
                _refreshGate.Release();
            }
        }

        private async Task RefreshActiveImagesAsync(int requestedOwnerId)
        {
            int[] activeOwnerIds;
            lock (_entryLock)
            {
                activeOwnerIds = _entries.Where(pair => pair.Value.ReferenceCount > 0 || pair.Key == requestedOwnerId)
                    .Select(pair => pair.Key).ToArray();
            }
            if (!_isDisposed && activeOwnerIds.Length > 0)
            {
                await _profileImageClient.SubscribeProfileImageChangesAsync(activeOwnerIds).ConfigureAwait(false);
                PlayerProfileImageReference[] references =
                    await _profileImageClient.GetPlayerProfileImagesAsync(activeOwnerIds).ConfigureAwait(false);
                foreach (PlayerProfileImageReference reference in references)
                {
                    await RefreshImageContentAsync(reference).ConfigureAwait(false);
                }
            }
        }

        private async Task RefreshImageContentAsync(PlayerProfileImageReference reference)
        {
            ProfileImageCacheEntry entry;
            lock (_entryLock)
            {
                entry = EnsureCacheEntry(reference.ProfileOwnerUserId);
            }
            bool hasChanged = entry.ProfileImageId != reference.ProfileImageId;
            byte[] imageBytes = entry.ImageBytes;
            if (hasChanged && reference.ProfileImageId != Guid.Empty)
            {
                ProfileImageContent content = await _profileImageClient.GetProfileImageAsync(reference.ProfileImageId)
                    .ConfigureAwait(false);
                if (content.NormalizedProfileImageBytes == null || content.NormalizedProfileImageBytes.Length >
                    ProfileImageLimits.MaximumStoredImageBytes)
                {
                    throw new ProfileImageOperationException(ProfileImageFailureCodes.InvalidStoredImage);
                }
                imageBytes = content.NormalizedProfileImageBytes;
            }
            lock (_entryLock)
            {
                entry.ProfileImageId = reference.ProfileImageId;
                entry.ImageBytes = reference.ProfileImageId == Guid.Empty ? null : imageBytes;
                entry.LastValidatedAtUtc = DateTime.UtcNow;
            }
            if (hasChanged)
            {
                ProfileImageChanged?.Invoke(reference.ProfileOwnerUserId);
            }
        }

        private void OnServerImageChanged(int profileOwnerUserId)
        {
            lock (_entryLock)
            {
                if (_entries.TryGetValue(profileOwnerUserId, out ProfileImageCacheEntry entry))
                {
                    entry.LastValidatedAtUtc = DateTime.MinValue;
                }
            }
            ScheduleRefresh();
        }

        private void ScheduleRefresh()
        {
            if (!_isDisposed && Interlocked.CompareExchange(ref _isRefreshScheduled, 1, 0) == 0)
            {
                _ = RefreshInBackgroundAsync();
            }
        }

        private async Task RefreshInBackgroundAsync()
        {
            await _refreshGate.WaitAsync().ConfigureAwait(false);
            try
            {
                await RefreshActiveImagesAsync(0).ConfigureAwait(false);
            }
            catch (ProfileImageOperationException ex)
            {
                Trace.TraceWarning("Profile image refresh deferred: {0}", ex.FailureCode);
            }
            finally
            {
                _refreshGate.Release();
                Interlocked.Exchange(ref _isRefreshScheduled, 0);
            }
        }

        public void Dispose()
        {
            _isDisposed = true;
            _refreshTimer.Dispose();
            _profileImageClient.ProfileImageChanged -= OnServerImageChanged;
            _ = CloseClientAsync();
        }

        private async Task CloseClientAsync()
        {
            await _refreshGate.WaitAsync().ConfigureAwait(false);
            try
            {
                _profileImageClient.Dispose();
            }
            finally
            {
                _refreshGate.Release();
            }
        }
    }
}
