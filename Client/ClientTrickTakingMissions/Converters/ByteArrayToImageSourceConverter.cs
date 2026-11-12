using System;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Windows.Data;
using System.Windows.Media.Imaging;
using ProfileImages;

namespace View.Converters
{
    /// <summary>
    /// Decodes normalized avatars in the WPF adapter and reuses frozen bitmap instances.
    /// </summary>
    public sealed class ByteArrayToImageSourceConverter : IValueConverter
    {
        private static readonly ConditionalWeakTable<byte[], BitmapImage> _decodedProfileImages =
            new ConditionalWeakTable<byte[], BitmapImage>();

        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            BitmapImage image = null;
            if (value is byte[] imageBytes && imageBytes.Length > 0 &&
                imageBytes.Length <= ProfileImageLimits.MaximumStoredImageBytes)
            {
                try
                {
                    image = _decodedProfileImages.GetValue(imageBytes, DecodeImage);
                }
                catch (NotSupportedException)
                {
                    image = null;
                }
                catch (IOException)
                {
                    image = null;
                }
                catch (ArgumentException)
                {
                    image = null;
                }
            }
            return image;
        }

        private static BitmapImage DecodeImage(byte[] imageBytes)
        {
            var image = new BitmapImage();
            using (var imageStream = new MemoryStream(imageBytes, false))
            {
                image.BeginInit();
                image.CacheOption = BitmapCacheOption.OnLoad;
                image.DecodePixelWidth = ProfileImageLimits.OutputPixelSize;
                image.StreamSource = imageStream;
                image.EndInit();
                image.Freeze();
            }
            return image;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            return Binding.DoNothing;
        }
    }
}
