using System.Windows.Markup;

namespace View.Properties.Langs
{
    /// <summary>Exposes profile text without editing generated resource accessors.</summary>
    public static class PlayerProfileResources
    {
        public static XmlLanguage InterfaceLanguage =>
            XmlLanguage.GetLanguage(Resources.Culture?.IetfLanguageTag ?? "es-MX");

        public static string Profile_Unavailable =>
            Resources.ResourceManager.GetString("Profile_Unavailable", Resources.Culture);

        public static string Profile_SaveChanges =>
            Resources.ResourceManager.GetString("Profile_SaveChanges", Resources.Culture);

        public static string Profile_CancelEditing =>
            Resources.ResourceManager.GetString("Profile_CancelEditing", Resources.Culture);

        public static string Profile_RetryLoad =>
            Resources.ResourceManager.GetString("Profile_RetryLoad", Resources.Culture);

        public static string Profile_PublicTitle =>
            Resources.ResourceManager.GetString("Profile_PublicTitle", Resources.Culture);

        public static string Profile_ClosePublicProfile =>
            Resources.ResourceManager.GetString("Profile_ClosePublicProfile", Resources.Culture);

        public static string Profile_ViewPublicProfile =>
            Resources.ResourceManager.GetString("Profile_ViewPublicProfile", Resources.Culture);

        public static string Profile_PublicReadOnly =>
            Resources.ResourceManager.GetString("Profile_PublicReadOnly", Resources.Culture);

        public static string Profile_GuestHasNoPublicProfile =>
            Resources.ResourceManager.GetString("Profile_GuestHasNoPublicProfile", Resources.Culture);
    }
}
