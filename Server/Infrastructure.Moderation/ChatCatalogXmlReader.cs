using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

using Domain;

namespace Infrastructure.Moderation
{
    /// <summary>Reads the catalog structure forward-only without retaining an XML document tree.</summary>
    internal static class ChatCatalogXmlReader
    {
        private const long MaximumCatalogCharacters = 262144;
        private const long MaximumCatalogFileBytes = 1048576;

        internal static XmlReader OpenReader(string catalogPath, bool isCombinedBackup)
        {
            long maximumCharacters = MaximumCatalogCharacters;
            if (isCombinedBackup)
            {
                maximumCharacters *= 2;
            }

            long maximumFileBytes = isCombinedBackup ? MaximumCatalogFileBytes * 2 : MaximumCatalogFileBytes;
            FileStream catalogStream = new FileStream(catalogPath, FileMode.Open, FileAccess.Read, FileShare.Read);
            XmlReader catalogReader = null;
            try
            {
                if (catalogStream.Length > maximumFileBytes)
                {
                    throw new InvalidDataException("The chat catalog exceeds its file size budget.");
                }

                catalogReader = XmlReader.Create(catalogStream, new XmlReaderSettings
                {
                    DtdProcessing = DtdProcessing.Prohibit,
                    XmlResolver = null,
                    MaxCharactersInDocument = maximumCharacters,
                    IgnoreComments = true,
                    IgnoreWhitespace = true,
                    CloseInput = true
                }, catalogPath);
            }
            finally
            {
                if (catalogReader == null)
                {
                    catalogStream.Dispose();
                }
            }

            return catalogReader;
        }

        internal static void ReadCatalog(XmlReader catalogReader, string expectedCulture,
            ChatCatalogReadState catalogState)
        {
            catalogReader.MoveToContent();
            if (catalogReader.Name != "catalog" || catalogReader.GetAttribute("culture") != expectedCulture)
            {
                throw CatalogError(catalogReader, "The catalog root or culture is invalid.");
            }

            int catalogDepth = catalogReader.Depth;
            while (catalogReader.Read() && catalogReader.Depth > catalogDepth)
            {
                ReadCatalogNode(catalogReader, expectedCulture, catalogState);
            }
        }

        internal static void ValidateCategories(IReadOnlyCollection<ProhibitedChatExpression> expressions)
        {
            foreach (string cultureName in new[] { "es-MX", "en-US" })
            {
                bool hasProfanity = expressions.Any(expression => expression.ExpressionCultureName == cultureName &&
                    expression.InfractionCategory == ChatInfractionCategory.Profanity);
                bool hasThreats = expressions.Any(expression => expression.ExpressionCultureName == cultureName &&
                    expression.InfractionCategory == ChatInfractionCategory.Threat);
                if (!hasProfanity || !hasThreats)
                {
                    throw new InvalidDataException("Each chat catalog must include Profanity and Threat categories.");
                }
            }
        }

        private static void ReadCatalogNode(XmlReader catalogReader, string cultureName,
            ChatCatalogReadState catalogState)
        {
            if (catalogReader.NodeType == XmlNodeType.Element)
            {
                if (catalogReader.Name != "expression")
                {
                    throw CatalogError(catalogReader, "Only expression elements are allowed inside a catalog.");
                }

                catalogState.AddExpression(ReadExpression(catalogReader, cultureName));
            }
            else if (catalogReader.NodeType != XmlNodeType.EndElement &&
                catalogReader.NodeType != XmlNodeType.Whitespace)
            {
                throw CatalogError(catalogReader, "Unexpected content inside the chat catalog.");
            }
        }

        private static ProhibitedChatExpression ReadExpression(XmlReader catalogReader, string cultureName)
        {
            ChatInfractionCategory infractionCategory = ReadCategory(catalogReader);
            bool canMatchObfuscation = XmlConvert.ToBoolean(catalogReader.GetAttribute("matchObfuscation") ?? "false");
            string expressionText;
            using (XmlReader expressionReader = catalogReader.ReadSubtree())
            {
                expressionReader.Read();
                expressionText = ReadExpressionText(expressionReader).Trim();
            }

            if (expressionText.Length == 0 ||
                expressionText.Length > ChatCatalogReadState.MaximumCatalogExpressionLength)
            {
                throw CatalogError(catalogReader, "The chat expression is empty or exceeds its length limit.");
            }

            return new ProhibitedChatExpression
            {
                ExpressionText = expressionText,
                ExpressionCultureName = cultureName,
                InfractionCategory = infractionCategory,
                CanMatchObfuscatedLetters = canMatchObfuscation
            };
        }

        private static string ReadExpressionText(XmlReader expressionReader)
        {
            StringBuilder expressionText = new StringBuilder();
            char[] expressionTextBuffer = new char[ChatCatalogReadState.MaximumCatalogExpressionLength];
            while (expressionReader.Read())
            {
                if (expressionReader.NodeType == XmlNodeType.Text || expressionReader.NodeType == XmlNodeType.CDATA ||
                    expressionReader.NodeType == XmlNodeType.SignificantWhitespace)
                {
                    AppendExpressionText(expressionReader, expressionText, expressionTextBuffer);
                }
                else if (expressionReader.NodeType == XmlNodeType.Element)
                {
                    throw CatalogError(expressionReader, "Nested elements are not allowed inside an expression.");
                }
            }

            return expressionText.ToString();
        }

        private static void AppendExpressionText(XmlReader expressionReader, StringBuilder expressionText,
            char[] expressionTextBuffer)
        {
            int readCharacterCount = expressionReader.ReadValueChunk(
                expressionTextBuffer, 0, expressionTextBuffer.Length);
            while (readCharacterCount > 0)
            {
                if (expressionText.Length + readCharacterCount > ChatCatalogReadState.MaximumCatalogExpressionLength)
                {
                    throw CatalogError(expressionReader, "The chat expression exceeds its length limit.");
                }

                expressionText.Append(expressionTextBuffer, 0, readCharacterCount);
                readCharacterCount = expressionReader.ReadValueChunk(
                    expressionTextBuffer, 0, expressionTextBuffer.Length);
            }
        }

        private static ChatInfractionCategory ReadCategory(XmlReader catalogReader)
        {
            ChatInfractionCategory infractionCategory;
            switch (catalogReader.GetAttribute("category"))
            {
                case "Profanity": infractionCategory = ChatInfractionCategory.Profanity; break;
                case "Threat": infractionCategory = ChatInfractionCategory.Threat; break;
                default: throw CatalogError(catalogReader, "The expression category must be Profanity or Threat.");
            }

            return infractionCategory;
        }

        private static InvalidDataException CatalogError(XmlReader catalogReader, string validationFailureReason)
        {
            IXmlLineInfo location = catalogReader as IXmlLineInfo;
            return new InvalidDataException(string.Format(CultureInfo.InvariantCulture,
                "{0} Source: {1}; line {2}.",
                new object[] { validationFailureReason, catalogReader.BaseURI, location?.LineNumber ?? 0 }));
        }
    }
}
