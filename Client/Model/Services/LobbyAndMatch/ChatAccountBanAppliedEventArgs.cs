using System;

using Model.GameServices;

namespace Model.Services
{
    /// <summary>Carries the private server account-ban notification to client-side subscribers.</summary>
    public sealed class ChatAccountBanAppliedEventArgs : EventArgs
    {
        public ChatAccountBanAppliedEventArgs(ChatAccountBanNotice chatAccountBanNotice)
        {
            ChatAccountBanNotice = chatAccountBanNotice;
        }

        public ChatAccountBanNotice ChatAccountBanNotice { get; }
    }
}
