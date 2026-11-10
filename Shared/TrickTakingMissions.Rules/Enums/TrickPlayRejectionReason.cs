using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TrickTakingMissions.Rules.Enums
{
    public enum TrickPlayRejectionReason
    {
        None,
        NotPlayerTurn, 
        CardNotInHand,
        MustFollowLeadSuit,
        RestrictedByPolicy
    }
}
