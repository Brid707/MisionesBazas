using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using Application.Models;
using Application.Ports;
using Services.Contracts;
using Services.Services;

namespace Services.Security
{
    /// <summary>Requires the issued guest credential and both active callbacks in the same room.</summary>
    public sealed class GuestLobbyProfileAccessPolicy : IGuestLobbyProfileAccess
    {
        public bool CanViewProfile(GuestLobbyProfileAccessRequest accessRequest)
        {
            bool isAllowed = GuestParticipantCredentials.IsGuestCredentialValid(accessRequest.GuestViewerUserId,
                accessRequest.GuestSessionToken);
            if (isAllowed)
            {
                KeyValuePair<int, ILobbyCallback>[] participants =
                    LobbyService.GetMatchCallbacks(accessRequest.LobbyCode);
                isAllowed = participants.Any(participant => participant.Key == accessRequest.GuestViewerUserId &&
                    (participant.Value as ICommunicationObject)?.State == CommunicationState.Opened) &&
                    participants.Any(participant => participant.Key == accessRequest.ProfileOwnerUserId &&
                    (participant.Value as ICommunicationObject)?.State == CommunicationState.Opened);
            }
            return isAllowed;
        }
    }
}
