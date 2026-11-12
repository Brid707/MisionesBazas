using System;
using System.IO;
using System.Xml;

using Application.Models;
using Application.Ports;
using Application.Ports.Logger;

namespace Application.UseCases
{
    /// <summary>Recovers catalog failures without preventing unrelated game services from starting.</summary>
    public sealed class ChatModerationStartup
    {
        private const string CatalogFailureTemplate =
            "Chat catalog preparation failed. Source {CatalogSource}; type {FailureType}; reason {FailureReason}.";
        private readonly IChatModerationCatalogBackup _moderationCatalogBackup;
        private readonly ILoggerService _moderationLogger;

        public ChatModerationStartup(IChatModerationCatalogBackup moderationCatalogBackup,
            ILoggerService moderationLogger)
        {
            _moderationCatalogBackup = moderationCatalogBackup;
            _moderationLogger = moderationLogger;
        }

        public ChatModerationPreparation PrepareChatModeration(string catalogDirectory)
        {
            ChatModerationPreparation moderationPreparation = TryPrepareCatalog(
                () => _moderationCatalogBackup.LoadEditableCatalog(catalogDirectory), "EditableCatalog");
            if (moderationPreparation.IsChatSendingAvailable)
            {
                TrySaveValidatedBackup(moderationPreparation);
                _moderationLogger.Information(
                    "Chat moderation is available with the validated editable bilingual catalog.");
            }
            else
            {
                moderationPreparation = TryPrepareCatalog(
                    _moderationCatalogBackup.LoadValidatedBackup, "ValidatedBackup");
                LogRecoveryAvailability(moderationPreparation.IsChatSendingAvailable);
            }

            return moderationPreparation;
        }

        private ChatModerationPreparation TryPrepareCatalog(Func<ChatModerationPreparation> prepareCatalog,
            string catalogSource)
        {
            ChatModerationPreparation moderationPreparation = new ChatModerationPreparation();
            try
            {
                moderationPreparation = prepareCatalog();
            }
            catch (InvalidDataException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (IOException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (XmlException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (FormatException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (ArgumentException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }
            catch (TimeoutException ex)
            {
                LogCatalogFailure(catalogSource, ex.GetType().Name, ex.Message);
            }

            return moderationPreparation;
        }

        private void TrySaveValidatedBackup(ChatModerationPreparation moderationPreparation)
        {
            try
            {
                _moderationCatalogBackup.SaveValidatedBackup(moderationPreparation);
            }
            catch (IOException ex)
            {
                LogCatalogFailure("BackupPublication", ex.GetType().Name, ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                LogCatalogFailure("BackupPublication", ex.GetType().Name, ex.Message);
            }
        }

        private void LogCatalogFailure(string catalogSource, string failureType, string failureReason)
        {
            _moderationLogger.Warning(CatalogFailureTemplate,
                new object[] { catalogSource, failureType, failureReason });
        }

        private void LogRecoveryAvailability(bool isChatSendingAvailable)
        {
            if (isChatSendingAvailable)
            {
                _moderationLogger.Warning("Chat moderation activated the last validated bilingual catalog backup.");
            }
            else
            {
                _moderationLogger.Error("Chat sending is disabled because no valid bilingual filter is available. " +
                    "Other game services can continue starting.");
            }
        }
    }
}
