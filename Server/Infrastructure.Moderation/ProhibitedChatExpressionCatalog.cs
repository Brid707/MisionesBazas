using System.Collections.Generic;
using System.IO;
using System.Xml;

using Application.Ports;
using Domain;

namespace Infrastructure.Moderation
{
    /// <summary>Loads both bounded XML catalogs once without retaining an XML document tree.</summary>
    public sealed class ProhibitedChatExpressionCatalog : IProhibitedChatExpressionCatalog
    {
        private readonly IReadOnlyCollection<ProhibitedChatExpression> _prohibitedChatExpressions;

        /// <summary>Validates both supported cultures before exposing any catalog expressions.</summary>
        public ProhibitedChatExpressionCatalog(string moderationCatalogDirectory)
        {
            ChatCatalogReadState catalogState = new ChatCatalogReadState();
            LoadCulture(moderationCatalogDirectory, "es-MX", catalogState);
            LoadCulture(moderationCatalogDirectory, "en-US", catalogState);
            _prohibitedChatExpressions = catalogState.Expressions;
            ChatCatalogXmlReader.ValidateCategories(_prohibitedChatExpressions);
        }

        /// <inheritdoc />
        public IReadOnlyCollection<ProhibitedChatExpression> GetAllSupportedLanguageExpressions()
        {
            return _prohibitedChatExpressions;
        }

        private static void LoadCulture(string directory, string cultureName, ChatCatalogReadState catalogState)
        {
            string catalogPath = Path.Combine(directory, "ProhibitedChatExpressions." + cultureName + ".xml");
            using (XmlReader catalogReader = ChatCatalogXmlReader.OpenReader(catalogPath, false))
            {
                ChatCatalogXmlReader.ReadCatalog(catalogReader, cultureName, catalogState);
                while (catalogReader.Read())
                {
                    // Validate the document end before activating a catalog.
                }
            }
        }
    }
}
