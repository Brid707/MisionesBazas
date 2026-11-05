using System.Reflection;
using System;


namespace ChatModeration.Tests
{
    internal static class TestRunner
    {
        private static int Main()
        {
            int failedTestCount = 0;
            int executedTestCount = 0;
            foreach (Type testClass in Assembly.GetExecutingAssembly().GetTypes())
            {
                if (testClass.Name.StartsWith("Tests", StringComparison.Ordinal))
                {
                    foreach (MethodInfo testMethod in testClass.GetMethods(BindingFlags.Public | BindingFlags.Static))
                    {
                        executedTestCount++;
                        try
                        {
                            testMethod.Invoke(null, null);
                            Console.WriteLine("PASS " + testClass.Name + "." + testMethod.Name);
                        }
                        catch (TargetInvocationException ex)
                        {
                            failedTestCount++;
                            Console.WriteLine("FAIL " + testMethod.Name + ": " + ex.InnerException);
                        }
                    }
                }
            }

            Console.WriteLine("Executed: " + executedTestCount + "; failed: " + failedTestCount);
            return failedTestCount;
        }
    }
}
