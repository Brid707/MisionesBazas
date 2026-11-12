using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Runtime.InteropServices;
using Application.Models;
using Application.Ports;
using ProfileImages;

namespace Infrastructure.ProfileImages
{
    /// <summary>
    /// Validates image dimensions before decoding and produces PNG avatars without original EXIF metadata.
    /// </summary>
    public sealed class ProfileImageProcessor : IProfileImageProcessor
    {
        public byte[] NormalizeProfileImage(byte[] selectedProfileImageBytes)
        {
            if (selectedProfileImageBytes == null || selectedProfileImageBytes.Length == 0 ||
                selectedProfileImageBytes.Length > ProfileImageLimits.MaximumUploadBytes)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageSizeExceeded);
            }
            ProfileImageHeader.ValidateDimensions(selectedProfileImageBytes);
            byte[] normalizedImage;
            try
            {
                using (var sourceStream = new MemoryStream(selectedProfileImageBytes, false))
                using (Image sourceImage = Image.FromStream(sourceStream, true, true))
                {
                    ApplyExifOrientation(sourceImage);
                    normalizedImage = EncodeNormalizedImage(sourceImage);
                }
            }
            catch (ArgumentException ex)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat, ex);
            }
            catch (ExternalException ex)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat, ex);
            }
            return normalizedImage;
        }

        private static byte[] EncodeNormalizedImage(Image sourceImage)
        {
            int outputSize = ProfileImageLimits.OutputPixelSize;
            byte[] normalizedImage;
            using (var targetImage = new Bitmap(outputSize, outputSize, PixelFormat.Format32bppArgb))
            using (Graphics graphics = Graphics.FromImage(targetImage))
            using (var targetStream = new MemoryStream())
            {
                graphics.Clear(Color.Transparent);
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                float imageScale = Math.Min((float)outputSize / sourceImage.Width,
                    (float)outputSize / sourceImage.Height);
                float imageWidth = sourceImage.Width * imageScale;
                float imageHeight = sourceImage.Height * imageScale;
                graphics.DrawImage(sourceImage, (outputSize - imageWidth) / 2, (outputSize - imageHeight) / 2,
                    imageWidth, imageHeight);
                targetImage.Save(targetStream, ImageFormat.Png);
                normalizedImage = targetStream.ToArray();
            }
            if (normalizedImage.Length > ProfileImageLimits.MaximumStoredImageBytes)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageSizeExceeded);
            }
            return normalizedImage;
        }

        private static void ApplyExifOrientation(Image sourceImage)
        {
            const int orientationPropertyId = 274;
            if (Array.IndexOf(sourceImage.PropertyIdList, orientationPropertyId) >= 0)
            {
                byte[] orientationBytes = sourceImage.GetPropertyItem(orientationPropertyId).Value;
                int orientation = orientationBytes.Length > 0 ? orientationBytes[0] : 1;
                RotateFlipType[] orientations =
                {
                    RotateFlipType.RotateNoneFlipNone, RotateFlipType.RotateNoneFlipNone,
                    RotateFlipType.RotateNoneFlipX, RotateFlipType.Rotate180FlipNone,
                    RotateFlipType.Rotate180FlipX, RotateFlipType.Rotate90FlipX,
                    RotateFlipType.Rotate90FlipNone, RotateFlipType.Rotate270FlipX,
                    RotateFlipType.Rotate270FlipNone
                };
                if (orientation > 0 && orientation < orientations.Length)
                {
                    sourceImage.RotateFlip(orientations[orientation]);
                }
            }
        }
    }
}
