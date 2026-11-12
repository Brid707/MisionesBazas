using System;
using ProfileImages;

namespace Model.Services
{
    /// <summary>
    /// Carries a stable image failure code for localized client feedback.
    /// </summary>
    public sealed class ProfileImageOperationException : Exception
    {
        public ProfileImageOperationException() : this(ProfileImageFailureCodes.OperationFailed)
        {
        }

        public ProfileImageOperationException(string failureCode) : this(failureCode, null)
        {
        }

        public ProfileImageOperationException(string failureCode, Exception innerException)
            : base(failureCode, innerException)
        {
            FailureCode = failureCode;
        }

        public string FailureCode { get; }
    }
}
