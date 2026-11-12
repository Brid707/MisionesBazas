using System;

namespace Application.Ports
{
    /// <summary>
    /// Validates and normalizes uploaded profile images without exposing imaging libraries.
    /// </summary>
    public interface IProfileImageProcessor
    {
        byte[] NormalizeProfileImage(byte[] selectedProfileImageBytes);
    }
}
