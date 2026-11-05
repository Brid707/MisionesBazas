using System.Collections.Generic;

using Domain;

namespace Application.Ports
{
    /// <summary>Provides the complete Spanish and English prohibited-expression catalog loaded by the server.</summary>
    public interface IProhibitedChatExpressionCatalog
    {
        IReadOnlyCollection<ProhibitedChatExpression> GetAllSupportedLanguageExpressions();
    }
}
