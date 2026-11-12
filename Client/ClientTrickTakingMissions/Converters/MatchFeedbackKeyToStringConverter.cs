using System;
using System.Globalization;
using System.Windows.Data;

namespace View.Converters
{
    /// <summary>Resolves match feedback resource keys in the selected interface language.</summary>
    public sealed class MatchFeedbackKeyToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string resourceKey = value as string ?? "Match_Connecting";
            return Properties.Langs.Resources.ResourceManager.GetString(resourceKey,
                Properties.Langs.Resources.Culture) ?? string.Empty;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
