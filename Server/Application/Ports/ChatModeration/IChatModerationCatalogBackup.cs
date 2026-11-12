using Application.Models;

namespace Application.Ports
{
    /// <summary>Prepares bounded catalogs and persists a complete validated bilingual backup.</summary>
    public interface IChatModerationCatalogBackup
    {
        ChatModerationPreparation LoadEditableCatalog(string catalogDirectory);

        ChatModerationPreparation LoadValidatedBackup();

        void SaveValidatedBackup(ChatModerationPreparation preparation);
    }
}
