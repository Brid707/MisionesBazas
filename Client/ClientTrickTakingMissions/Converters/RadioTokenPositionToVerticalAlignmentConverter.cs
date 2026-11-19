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
            VerticalAlignment resolvedAlignment = VerticalAlignment.Center;
            if (value is RadioTokenPosition tokenPosition)
            {
                switch (tokenPosition)
                {
                    case RadioTokenPosition.Highest:
                        resolvedAlignment = VerticalAlignment.Top;
                        break;
                    case RadioTokenPosition.Lowest:
                        resolvedAlignment = VerticalAlignment.Bottom;
                        break;
                    case RadioTokenPosition.Only:
                    case RadioTokenPosition.Interference:
                    default:
                        resolvedAlignment = VerticalAlignment.Center;
                        break;
                }
            }
            return resolvedAlignment;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
