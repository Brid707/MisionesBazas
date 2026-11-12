using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

using Application.Models;
using Application.Ports;
using Domain;

namespace Infrastructure.Moderation
{
    /// <summary>Prepares bilingual filters and atomically stores their validated source expressions.</summary>
    public sealed class ChatModerationCatalogBackup : IChatModerationCatalogBackup
    {
        private readonly string _validatedBackupPath;

        public ChatModerationCatalogBackup(string validatedBackupPath)
        {
            _validatedBackupPath = validatedBackupPath;
        }

        public ChatModerationPreparation LoadEditableCatalog(string catalogDirectory)
        {
            IProhibitedChatExpressionCatalog catalog = new ProhibitedChatExpressionCatalog(catalogDirectory);
            return PrepareExpressions(catalog.GetAllSupportedLanguageExpressions());
        }

        public ChatModerationPreparation LoadValidatedBackup()
        {
            ChatCatalogReadState catalogState = new ChatCatalogReadState();
            using (XmlReader catalogReader = ChatCatalogXmlReader.OpenReader(_validatedBackupPath, true))
            {
                ReadBackup(catalogReader, catalogState);
            }

            IReadOnlyCollection<ProhibitedChatExpression> prohibitedChatExpressions = catalogState.Expressions;
            ChatCatalogXmlReader.ValidateCategories(prohibitedChatExpressions);
            return PrepareExpressions(prohibitedChatExpressions);
        }

        public void SaveValidatedBackup(ChatModerationPreparation moderationPreparation)
        {
            if (!moderationPreparation.IsChatSendingAvailable)
            {
                throw new ArgumentException("An unavailable filter cannot replace a validated catalog backup.");
            }

            Directory.CreateDirectory(Path.GetDirectoryName(_validatedBackupPath));
            string pendingBackupPath = _validatedBackupPath + "." + Guid.NewGuid().ToString("N") + ".tmp";
            WriteBackup(pendingBackupPath, moderationPreparation.Expressions);
            // Replacement preserves the previous complete version if publication fails.
            if (File.Exists(_validatedBackupPath))
            {
                File.Replace(pendingBackupPath, _validatedBackupPath, null);
            }
            else
            {
                File.Move(pendingBackupPath, _validatedBackupPath);
            }
        }

        private static ChatModerationPreparation PrepareExpressions(
            IReadOnlyCollection<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            return new ChatModerationPreparation
            {
                Expressions = prohibitedChatExpressions,
                MessageModerator = new ChatMessageModerator(prohibitedChatExpressions)
            };
        }

        private static void ReadBackup(XmlReader catalogReader, ChatCatalogReadState catalogState)
        {
            catalogReader.MoveToContent();
            if (catalogReader.Name != "catalogBackup" || catalogReader.GetAttribute("version") != "1")
            {
                throw new InvalidDataException("The validated catalog backup format is invalid.");
            }

            HashSet<string> loadedCultures = new HashSet<string>();
            while (catalogReader.Read())
            {
                if (catalogReader.NodeType == XmlNodeType.Element)
                {
                    ReadBackupCulture(catalogReader, catalogState, loadedCultures);
                }
                else if (catalogReader.NodeType != XmlNodeType.EndElement &&
                    catalogReader.NodeType != XmlNodeType.Whitespace)
                {
                    throw new InvalidDataException("Unexpected catalog backup content.");
                }
            }

            if (loadedCultures.Count != 2)
            {
                throw new InvalidDataException("The validated backup must contain both supported cultures.");
            }
        }

        private static void ReadBackupCulture(XmlReader catalogReader, ChatCatalogReadState catalogState,
            HashSet<string> loadedCultures)
        {
            string cultureName = catalogReader.GetAttribute("culture");
            if (catalogReader.Depth != 1 || (cultureName != "es-MX" && cultureName != "en-US") ||
                !loadedCultures.Add(cultureName))
            {
                throw new InvalidDataException("The validated backup contains an invalid or repeated culture.");
            }

            using (XmlReader cultureReader = catalogReader.ReadSubtree())
            {
                ChatCatalogXmlReader.ReadCatalog(cultureReader, cultureName, catalogState);
            }
        }

        private static void WriteBackup(string backupPath,
            IReadOnlyCollection<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            XmlWriterSettings backupWriterSettings = new XmlWriterSettings
            {
                Encoding = new UTF8Encoding(false),
                Indent = true,
                NewLineChars = "\r\n"
            };
            using (XmlWriter catalogWriter = XmlWriter.Create(backupPath, backupWriterSettings))
            {
                catalogWriter.WriteStartElement("catalogBackup");
                catalogWriter.WriteAttributeString("version", "1");
                foreach (string cultureName in new[] { "es-MX", "en-US" })
                {
                    WriteCulture(catalogWriter, cultureName, prohibitedChatExpressions);
                }

                catalogWriter.WriteEndElement();
            }
        }

        private static void WriteCulture(XmlWriter catalogWriter, string cultureName,
            IReadOnlyCollection<ProhibitedChatExpression> prohibitedChatExpressions)
        {
            catalogWriter.WriteStartElement("catalog");
            catalogWriter.WriteAttributeString("culture", cultureName);
            foreach (ProhibitedChatExpression expression in
                prohibitedChatExpressions.Where(expression => expression.ExpressionCultureName == cultureName))
            {
                catalogWriter.WriteStartElement("expression");
                catalogWriter.WriteAttributeString("category", expression.InfractionCategory.ToString());
                catalogWriter.WriteAttributeString("matchObfuscation",
                    XmlConvert.ToString(expression.CanMatchObfuscatedLetters));
                catalogWriter.WriteString(expression.ExpressionText);
                catalogWriter.WriteEndElement();
            }

            catalogWriter.WriteEndElement();
        }
    }
}
