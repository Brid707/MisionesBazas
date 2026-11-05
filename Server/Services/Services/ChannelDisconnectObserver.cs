using System;
using System.ServiceModel;
using Services.Contracts.Friendship;

namespace Services.Services
{
    internal sealed class ChannelDisconnectObserver
    {
        private readonly FriendshipService _service;
        private readonly int _userId;
        private readonly IFriendshipServiceCallback _callback;

        public ChannelDisconnectObserver(FriendshipService service, int userId, IFriendshipServiceCallback callback)
        {
            _service = service ?? throw new ArgumentNullException(nameof(service));
            _userId = userId;
            _callback = callback ?? throw new ArgumentNullException(nameof(callback));
        }

        public void OnChannelClosedOrFaulted(object sender, EventArgs e)
        {
            if (sender is ICommunicationObject channel)
            {
                channel.Closed -= OnChannelClosedOrFaulted;
                channel.Faulted -= OnChannelClosedOrFaulted;
            }

            _service.HandleSubscriberChannelClosed(_userId, _callback);
        }
    }
}
