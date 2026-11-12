using System;
using System.Globalization;
using System.Windows.Data;

namespace View.Converters
{
    /// <summary>Maps official card IDs to packaged client artwork; never requests images from a database.</summary>
    public sealed class CardIdToImagePathConverter : IValueConverter
    {
        private static readonly string[] s_normalSuits = { "Diamond", "Club", "Heart", "Spade" };
        private static readonly string[] s_specialSuits = { "Spade", "Heart", "Club", "Diamond" };
        private static readonly string[] s_cardNumbers =
            { "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string cardPath = "/View;component/Assets/Images/Cards/Card_Back_Default.png";
            if (value is int cardId && cardId >= 1 && cardId <= 40)
            {
                string cardSuit = cardId <= 36 ? s_normalSuits[(cardId - 1) / 9] : s_specialSuits[cardId - 37];
                string cardNumber = cardId <= 36 ? s_cardNumbers[(cardId - 1) % 9] : "King";
                cardPath = string.Format(CultureInfo.InvariantCulture,
                    "/View;component/Assets/Images/Cards/Card_{0}_{1}.png", cardSuit, cardNumber);
            }
            return cardPath;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
