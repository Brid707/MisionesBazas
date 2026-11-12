using System;
using ProfileImages;

namespace Application.Models
{
    /// <summary>
    /// Reports an expected profile image validation failure independently of WCF.
    /// </summary>
    public sealed class ProfileImageException : Exception
    {
        public ProfileImageException() : this(ProfileImageFailureCodes.OperationFailed)
        {
        }

        public ProfileImageException(string failureCode) : this(failureCode, null)
        {
        }

        public ProfileImageException(string failureCode, Exception innerException)
            : base(failureCode, innerException)
        {
            FailureCode = failureCode;
        }

        public string FailureCode { get; }
    }
}
