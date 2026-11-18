using System;
using System.Globalization;
using System.Windows.Data;

namespace View.Converters
{
    /// <summary>Resolves packaged artwork using the official shared card metadata.</summary>
    public sealed class MissionObjectiveCardIdToImagePathConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return CardArtworkPathResolver.ResolveCardPath(value, true);
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
