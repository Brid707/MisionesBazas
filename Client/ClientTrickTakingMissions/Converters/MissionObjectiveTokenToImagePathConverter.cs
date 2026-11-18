using System;
using System.Collections.Generic;
using System.Globalization;
using System.Windows.Data;
using Gameplay;

namespace View.Converters
{
    public sealed class MissionObjectiveTokenToImagePathConverter : IValueConverter
    {
        private static readonly IReadOnlyDictionary<MissionObjectiveToken, string> s_tokenFiles =
            new Dictionary<MissionObjectiveToken, string>
            {
                { MissionObjectiveToken.OrderOne, "Order_One" },
                { MissionObjectiveToken.OrderTwo, "Order_Two" },
                { MissionObjectiveToken.OrderThree, "Order_Three" },
                { MissionObjectiveToken.OrderFour, "Order_Four" },
                { MissionObjectiveToken.OrderFive, "Order_Five" },
                { MissionObjectiveToken.ArrowOne, "Arrow_One" },
                { MissionObjectiveToken.ArrowTwo, "Arrow_Two" },
                { MissionObjectiveToken.ArrowThree, "Arrow_Three" },
                { MissionObjectiveToken.ArrowFour, "Arrow_Four" },
                { MissionObjectiveToken.Omega, "Omega" }
            };

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string tokenPath = null;
            if (value is MissionObjectiveToken token && s_tokenFiles.TryGetValue(token, out string tokenFile))
            {
                tokenPath = string.Format(CultureInfo.InvariantCulture,
                    "/View;component/Assets/Images/Tokens/ObjectiveMarkers/Token_{0}.png", tokenFile);
            }
            return tokenPath;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
