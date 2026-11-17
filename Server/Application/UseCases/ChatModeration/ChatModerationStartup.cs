using System;
using System.IO;
using System.Xml;

using Application.Models;
using Application.Ports;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Application.UseCases
{
    /// <summary>Recovers catalog failures without preventing unrelated game services from starting.</summary>
    public sealed class ChatModerationStartup
    {
        private const string CatalogFailureTemplate =
            "Chat catalog preparation failed. Source {CatalogSource}; type {FailureType}; reason {FailureReason}.";
        private const string ChatModerationAvailableEditableCatalogTemplate =
            "Chat moderation is available with the validated editable bilingual catalog.";
        private const string ChatModerationBackupActivatedTemplate =
            "Chat moderation activated the last validated bilingual catalog backup.";
        private const string ChatModerationDisabledNoFilterAvailableTemplate =
            "Chat sending is disabled because no valid bilingual filter is available. Other game services can " +
            "continue starting.";

        private const string CatalogSourceEditableCatalog = "EditableCatalog";
        private const string CatalogSourceValidatedBackup = "ValidatedBackup";
        private const string CatalogSourceBackupPublication = "BackupPublication";

        private readonly IChatModerationCatalogBackup _moderationCatalogBackup;
        private readonly ILoggerService _moderationLogger;

        public ChatModerationStartup(IChatModerationCatalogBackup moderationCatalogBackup,
            ILoggerService moderationLogger)
        {
            _moderationCatalogBackup = moderationCatalogBackup ??
                throw new ArgumentNullException(nameof(moderationCatalogBackup));
            _moderationLogger = moderationLogger ?? throw new ArgumentNullException(nameof(moderationLogger));
        }

        public ChatModerationPreparation PrepareChatModeration(string catalogDirectory)
        {
            ChatModerationPreparation moderationPreparation = TryPrepareCatalog(
                () => _moderationCatalogBackup.LoadEditableCatalog(catalogDirectory), CatalogSourceEditableCatalog);
            if (moderationPreparation.IsChatSendingAvailable)
            {
                TrySaveValidatedBackup(moderationPreparation);
                _moderationLogger.Information(ChatModerationAvailableEditableCatalogTemplate);
            }
            else
            {
                moderationPreparation = TryPrepareCatalog(
                    _moderationCatalogBackup.LoadValidatedBackup, CatalogSourceValidatedBackup);
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
                LogCatalogFailure(CatalogSourceBackupPublication, ex.GetType().Name, ex.Message);
            }
            catch (UnauthorizedAccessException ex)
            {
                LogCatalogFailure(CatalogSourceBackupPublication, ex.GetType().Name, ex.Message);
            }
        }

        private void LogCatalogFailure(string catalogSource, string failureType, string failureReason)
        {
            _moderationLogger.Warning(CatalogFailureTemplate, catalogSource, failureType, failureReason);
        }

        private void LogRecoveryAvailability(bool isChatSendingAvailable)
        {
            if (isChatSendingAvailable)
            {
                _moderationLogger.Warning(ChatModerationBackupActivatedTemplate);
            }
            else
            {
                _moderationLogger.Error(ChatModerationDisabledNoFilterAvailableTemplate);
            }
        }
    }
}
