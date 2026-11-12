using System;
using System.Globalization;
using System.Windows.Data;
using ViewModel.Constants;

namespace View.Converters
{
    /// <summary>
    /// Maps image operation codes to localized presentation text.
    /// </summary>
    public sealed class ProfileImageFeedbackToStringConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string feedback = string.Empty;
            if (value is ProfileImageFeedback profileImageFeedback && profileImageFeedback != ProfileImageFeedback.None)
            {
                string resourceKey = "Profile_Image_" + profileImageFeedback;
                feedback = Properties.Langs.Resources.ResourceManager.GetString(resourceKey,
                    Properties.Langs.Resources.Culture) ?? Properties.Langs.Resources.Profile_Image_OperationFailed;
            }
            return feedback;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
