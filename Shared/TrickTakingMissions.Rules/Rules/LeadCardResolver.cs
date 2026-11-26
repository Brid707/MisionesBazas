using System.Collections.Generic;
using System.Linq;
using TrickTakingMissions.Rules.Models;

namespace TrickTakingMissions.Rules.Rules
{
    public static class LeadCardResolver
    {
        public static TrickCardPlay GetLeadPlay(IReadOnlyList<TrickCardPlay> trickPlays)
        {
            TrickCardPlay leadPlay = null;

            if (trickPlays != null)
            {
                foreach (TrickCardPlay trickPlay in trickPlays)
                {
                    if (leadPlay is null || trickPlay.PlayOrder < leadPlay.PlayOrder)
                    {
                        leadPlay = trickPlay;
                    }
                }
            }

            return leadPlay;
        }
    }
}
