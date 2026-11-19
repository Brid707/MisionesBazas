using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using TrickTakingMissions.Rules.Enums;

namespace View.Converters
{
    /// <summary>
    /// Converts a radio token position to vertical alignment on a card.
    /// </summary>
    public sealed class RadioTokenPositionToVerticalAlignmentConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is RadioTokenPosition tokenPosition)
            {
                switch (tokenPosition)
                {
                    case RadioTokenPosition.Highest:
                        return VerticalAlignment.Top;
                    case RadioTokenPosition.Lowest:
                        return VerticalAlignment.Bottom;
                    case RadioTokenPosition.Only:
                    case RadioTokenPosition.Interference:
                    default:
                        return VerticalAlignment.Center;
                }
            }

            return VerticalAlignment.Center;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
