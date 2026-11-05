using System;


namespace ChatModeration.Tests
{
    internal static class TestAssert
    {
        public static void Equal<T>(T expectedValue, T actualValue)
        {
            if (!object.Equals(expectedValue, actualValue))
            {
                throw new InvalidOperationException("Expected " + expectedValue + "; actual " + actualValue);
            }
        }
    }
}
