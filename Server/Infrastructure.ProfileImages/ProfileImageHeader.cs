using System;
using System.Linq;
using System.Text;
using Application.Models;
using ProfileImages;

namespace Infrastructure.ProfileImages
{
    internal static class ProfileImageHeader
    {
        private static readonly byte[] _pngSignature = { 137, 80, 78, 71, 13, 10, 26, 10 };

        internal static void ValidateDimensions(byte[] imageBytes)
        {
            int imageWidth = 0;
            int imageHeight = 0;
            if (HasPngHeader(imageBytes))
            {
                imageWidth = ReadBigEndianInteger(imageBytes, 16);
                imageHeight = ReadBigEndianInteger(imageBytes, 20);
            }
            else
            {
                ReadJpegDimensions(imageBytes, out imageWidth, out imageHeight);
            }
            ValidatePixelBudget(imageWidth, imageHeight);
        }

        private static bool HasPngHeader(byte[] imageBytes)
        {
            return imageBytes.Length >= 24 && imageBytes.Take(8).SequenceEqual(_pngSignature) &&
                Encoding.ASCII.GetString(imageBytes, 12, 4) == "IHDR";
        }

        private static void ValidatePixelBudget(int imageWidth, int imageHeight)
        {
            bool isWithinBudget = imageWidth > 0 && imageHeight > 0 &&
                imageWidth <= ProfileImageLimits.MaximumSourceDimension &&
                imageHeight <= ProfileImageLimits.MaximumSourceDimension &&
                (long)imageWidth * imageHeight <= ProfileImageLimits.MaximumPixelCount;
            if (!isWithinBudget)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.ImageDimensionsExceeded);
            }
        }

        private static void ReadJpegDimensions(byte[] imageBytes, out int imageWidth, out int imageHeight)
        {
            imageWidth = 0;
            imageHeight = 0;
            if (imageBytes.Length < 4 || imageBytes[0] != 255 || imageBytes[1] != 216)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat);
            }
            int segmentPosition = 2;
            while (segmentPosition + 3 < imageBytes.Length && imageWidth == 0)
            {
                int segmentMarker = ReadJpegMarker(imageBytes, ref segmentPosition);
                int segmentLength = ReadSegmentLength(imageBytes, segmentPosition);
                bool hasDimensions = segmentMarker == 192 || segmentMarker == 193 || segmentMarker == 194;
                if (hasDimensions && segmentLength >= 8)
                {
                    imageHeight = imageBytes[segmentPosition + 3] * 256 + imageBytes[segmentPosition + 4];
                    imageWidth = imageBytes[segmentPosition + 5] * 256 + imageBytes[segmentPosition + 6];
                }
                segmentPosition += segmentLength;
            }
        }

        private static int ReadJpegMarker(byte[] imageBytes, ref int segmentPosition)
        {
            if (imageBytes[segmentPosition++] != 255)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat);
            }
            while (segmentPosition < imageBytes.Length && imageBytes[segmentPosition] == 255)
            {
                segmentPosition++;
            }
            if (segmentPosition + 2 >= imageBytes.Length)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat);
            }
            return imageBytes[segmentPosition++];
        }

        private static int ReadSegmentLength(byte[] imageBytes, int segmentPosition)
        {
            int segmentLength = imageBytes[segmentPosition] * 256 + imageBytes[segmentPosition + 1];
            if (segmentLength < 2 || segmentLength > imageBytes.Length - segmentPosition)
            {
                throw new ProfileImageException(ProfileImageFailureCodes.InvalidImageFormat);
            }
            return segmentLength;
        }

        private static int ReadBigEndianInteger(byte[] bytes, int position)
        {
            return (bytes[position] << 24) | (bytes[position + 1] << 16) |
                (bytes[position + 2] << 8) | bytes[position + 3];
        }
    }
}
