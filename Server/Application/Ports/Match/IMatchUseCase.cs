using System;
using Gameplay;

namespace Application.Ports
{
    /// <summary>Coordinates authoritative dealing, private snapshots and atomic card plays.</summary>
    public interface IMatchUseCase
    {
        Application.Models.ObjectiveDraftDecision ProcessObjectiveDraftAction(
            Application.Models.ObjectiveDraftSubmission submission, int participantUserId);
        Guid StartMatch(string lobbyCode, int[] participantUserIds, Guid lobbyInstanceId = default(Guid));
        PlayerMatchSnapshot GetPlayerMatch(string lobbyCode, int participantUserId);
        CardPlayDecision PlayCard(CardPlaySubmission cardPlaySubmission, int participantUserId);
    }
}
