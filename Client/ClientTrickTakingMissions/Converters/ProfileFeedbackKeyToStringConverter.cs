using System;
using System.Globalization;
using System.Windows.Data;

namespace View.Converters
{
    /// <summary>Resolves profile feedback keys using the selected interface culture.</summary>
    public sealed class ProfileFeedbackKeyToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string resourceKey = value as string ?? string.Empty;
            return Properties.Langs.Resources.ResourceManager.GetString(resourceKey,
                Properties.Langs.Resources.Culture) ?? string.Empty;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
