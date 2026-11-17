using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading;
using Application.Models;
using ProfileImages;
using Services.Contracts;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Services.Services
{
    internal sealed class ProfileImageSubscriptions
    {
        private const int MaximumSubscriptions = 128;
        private readonly object _subscriptionLock = new object();
        private readonly Dictionary<string, Subscription> _subscriptions = new Dictionary<string, Subscription>();
        private readonly ILoggerService _logger;
        private readonly HashSet<int> _pendingOwnerIds = new HashSet<int>();
        private bool _isDeliveryRunning;

        internal ProfileImageSubscriptions(ILoggerService logger)
        {
            _logger = logger;
        }

        internal void Subscribe(int[] profileOwnerUserIds)
        {
            if (profileOwnerUserIds == null || profileOwnerUserIds.Length > ProfileImageLimits.MaximumRequestedPlayers)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageRequest);
            }
            OperationContext context = OperationContext.Current;
            string sessionId = context.SessionId;
            IProfileImageCallback callback = context.GetCallbackChannel<IProfileImageCallback>();
            lock (_subscriptionLock)
            {
                bool isNewSubscription = !_subscriptions.ContainsKey(sessionId);
                if (isNewSubscription && _subscriptions.Count >= MaximumSubscriptions)
                {
                    throw new ProfileImageException(ProfileImageFailureCodes.ImageServiceBusy);
                }
                _subscriptions[sessionId] = new Subscription(callback, profileOwnerUserIds);
                if (isNewSubscription)
                {
                    context.Channel.Closed += (_, __) => RemoveSubscription(sessionId);
                    context.Channel.Faulted += (_, __) => RemoveSubscription(sessionId);
                }
            }
        }

        internal void Publish(int profileOwnerUserId)
        {
            bool shouldStartDelivery = false;
            lock (_subscriptionLock)
            {
                if (_pendingOwnerIds.Count < ProfileImageLimits.MaximumRequestedPlayers)
                {
                    _pendingOwnerIds.Add(profileOwnerUserId);
                    if (!_isDeliveryRunning)
                    {
                        _isDeliveryRunning = true;
                        shouldStartDelivery = true;
                    }
                }
                else
                {
                    _logger.Warning("Profile image notification deferred to client reconciliation.");
                }
            }
            if (shouldStartDelivery)
            {
                ThreadPool.QueueUserWorkItem(DeliverPendingNotifications);
            }
        }

        private void DeliverPendingNotifications(object _)
        {
            int profileOwnerUserId;
            while (HasDequeuedPendingProfileImageOwner(out profileOwnerUserId))
            {
                NotifyAllSubscribers(profileOwnerUserId);
            }
        }

        private bool HasDequeuedPendingProfileImageOwner(out int profileOwnerUserId)
        {
            profileOwnerUserId = 0;
            bool hasPendingOwner;
            lock (_subscriptionLock)
            {
                hasPendingOwner = _pendingOwnerIds.Count > 0;
                if (hasPendingOwner)
                {
                    profileOwnerUserId = _pendingOwnerIds.First();
                    _pendingOwnerIds.Remove(profileOwnerUserId);
                }
                else
                {
                    _isDeliveryRunning = false;
                }
            }
            return hasPendingOwner;
        }

        private void NotifyAllSubscribers(int profileOwnerUserId)
        {
            KeyValuePair<string, Subscription>[] subscribers;
            lock (_subscriptionLock)
            {
                subscribers = _subscriptions.Where(pair => pair.Value.OwnerIds.Contains(profileOwnerUserId)).ToArray();
            }
            foreach (KeyValuePair<string, Subscription> subscriber in subscribers)
            {
                NotifySubscriber(subscriber, profileOwnerUserId);
            }
        }

        private void NotifySubscriber(KeyValuePair<string, Subscription> subscriber, int profileOwnerUserId)
        {
            try
            {
                subscriber.Value.Callback.OnPlayerProfileImageChanged(profileOwnerUserId);
            }
            catch (CommunicationException ex)
            {
                RemoveSubscription(subscriber.Key);
                _logger.Error(ex, "Profile image subscriber disconnected for account {AccountId}.",
                    profileOwnerUserId);
            }
            catch (InvalidOperationException ex)
            {
                RemoveSubscription(subscriber.Key);
                _logger.Error(ex, "Profile image callback channel is no longer usable.");
            }
            catch (TimeoutException ex)
            {
                RemoveSubscription(subscriber.Key);
                _logger.Error(ex, "Profile image subscriber timed out for account {AccountId}.",
                    profileOwnerUserId);
            }
        }

        private void RemoveSubscription(string sessionId)
        {
            lock (_subscriptionLock)
            {
                _subscriptions.Remove(sessionId);
            }
        }

        private sealed class Subscription
        {
            internal Subscription(IProfileImageCallback callback, int[] ownerIds)
            {
                Callback = callback;
                OwnerIds = new HashSet<int>(ownerIds.Where(ownerId => ownerId > 0));
            }

            internal IProfileImageCallback Callback { get; }
            internal HashSet<int> OwnerIds { get; }
        }
    }
}
