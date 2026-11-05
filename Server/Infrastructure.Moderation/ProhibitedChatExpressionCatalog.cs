using System.Collections.Generic;
using System.IO;
using System.Xml.Linq;
using System.Xml;
using System;

using Application.Ports;
using Domain;

namespace Infrastructure.Moderation
{
    /// <summary>Loads and validates both server XML catalogs once; external XML entities are prohibited.</summary>
    public sealed class ProhibitedChatExpressionCatalog : IProhibitedChatExpressionCatalog
    {
        private const int MaximumCatalogCharacters = 262144;
        private readonly IReadOnlyCollection<ProhibitedChatExpression> _prohibitedChatExpressions;

        public ProhibitedChatExpressionCatalog(string moderationCatalogDirectory)
        {
            List<ProhibitedChatExpression> prohibitedChatExpressions = new List<ProhibitedChatExpression>();
            LoadCatalog(moderationCatalogDirectory, "es-MX", prohibitedChatExpressions);
            LoadCatalog(moderationCatalogDirectory, "en-US", prohibitedChatExpressions);
            _prohibitedChatExpressions = prohibitedChatExpressions.AsReadOnly();
        }

        public IReadOnlyCollection<ProhibitedChatExpression> GetAllSupportedLanguageExpressions()
        {
            return _prohibitedChatExpressions;
        }

        private static void LoadCatalog(string moderationCatalogDirectory, string expressionCultureName,
            List<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            string catalogPath = Path.Combine(moderationCatalogDirectory,
                "ProhibitedChatExpressions." + expressionCultureName + ".xml");
            XmlReaderSettings catalogReaderSettings = new XmlReaderSettings
            {
                DtdProcessing = DtdProcessing.Prohibit,
                XmlResolver = null,
                MaxCharactersInDocument = MaximumCatalogCharacters
            };
            using (XmlReader catalogReader = XmlReader.Create(catalogPath, catalogReaderSettings))
            {
                XElement catalogRoot = XDocument.Load(catalogReader).Root;
                if (catalogRoot == null || (string)catalogRoot.Attribute("culture") != expressionCultureName)
                {
                    throw new InvalidDataException("The chat moderation catalog culture is invalid.");
                }

                foreach (XElement catalogExpression in catalogRoot.Elements("expression"))
                {
                    prohibitedChatExpressions.Add(ParseCatalogExpression(catalogExpression, expressionCultureName));
                }
            }
        }

        private static ProhibitedChatExpression ParseCatalogExpression(XElement catalogExpression,
            string expressionCultureName)
        {
            ChatInfractionCategory infractionCategory;
            bool hasValidCategory = Enum.TryParse(
                (string)catalogExpression.Attribute("category"), out infractionCategory);
            string expressionText = catalogExpression.Value.Trim();
            if (!hasValidCategory || infractionCategory == ChatInfractionCategory.None ||
                !Enum.IsDefined(typeof(ChatInfractionCategory), infractionCategory) ||
                string.IsNullOrWhiteSpace(expressionText))
            {
                throw new InvalidDataException("The chat moderation catalog contains an invalid expression.");
            }

            return new ProhibitedChatExpression
            {
                ExpressionText = expressionText,
                ExpressionCultureName = expressionCultureName,
                InfractionCategory = infractionCategory,
                CanMatchObfuscatedLetters = (bool?)catalogExpression.Attribute("matchObfuscation") ?? false
            };
        }
    }
}
