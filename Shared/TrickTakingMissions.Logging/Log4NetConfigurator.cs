using System;
using System.IO;
using System.Text;
using log4net;
using log4net.Appender;
using log4net.Core;
using log4net.Layout;
using log4net.Repository.Hierarchy;

namespace TrickTakingMissions.Logging
{
    /// <summary>Programmatically configures log4net with a rolling file appender and PatternLayout.</summary>
    public static class Log4NetConfigurator
    {
        private const string RollingFileAppenderName = "RollingFileAppender";
        private const string ConversionPatternText =
            "%date{yyyy-MM-dd HH:mm:ss.fff} [%thread] %-5level %logger - %message%newline%exception";
        private const string RollingDatePatternText = "_yyyy-MM-dd'.log'";
        private const string MaximumFileSizeText = "10MB";
        private const string EmptyDirectoryMessage = "Logs directory must not be null or whitespace.";
        private const string EmptyFileNameMessage = "Log file name must not be null or whitespace.";
        private const int MaximumRollBackupsCount = 10;

        public static void Configure(string logsDirectory, string logFileName)
        {
            ConfigureWithMinimumLevel(logsDirectory, logFileName, Level.Info);
        }

        public static void ConfigureWithMinimumLevel(string logsDirectory, string logFileName, Level minimumLevel)
        {
            if (string.IsNullOrWhiteSpace(logsDirectory))
            {
                throw new ArgumentException(EmptyDirectoryMessage, nameof(logsDirectory));
            }

            if (string.IsNullOrWhiteSpace(logFileName))
            {
                throw new ArgumentException(EmptyFileNameMessage, nameof(logFileName));
            }

            if (minimumLevel == null)
            {
                throw new ArgumentNullException(nameof(minimumLevel));
            }

            Hierarchy repositoryHierarchy = (Hierarchy)LogManager.GetRepository();

            if (!repositoryHierarchy.Configured)
            {
                Directory.CreateDirectory(logsDirectory);

                PatternLayout patternLayout = new PatternLayout
                {
                    ConversionPattern = ConversionPatternText
                };
                patternLayout.ActivateOptions();

                string logFilePath = Path.Combine(logsDirectory, logFileName);
                RollingFileAppender rollingFileAppender = new RollingFileAppender
                {
                    Name = RollingFileAppenderName,
                    File = logFilePath,
                    AppendToFile = true,
                    RollingStyle = RollingFileAppender.RollingMode.Composite,
                    DatePattern = RollingDatePatternText,
                    MaxSizeRollBackups = MaximumRollBackupsCount,
                    MaximumFileSize = MaximumFileSizeText,
                    StaticLogFileName = true,
                    Encoding = Encoding.UTF8,
                    LockingModel = new FileAppender.MinimalLock(),
                    Layout = patternLayout
                };
                rollingFileAppender.ActivateOptions();

                repositoryHierarchy.Root.AddAppender(rollingFileAppender);
                repositoryHierarchy.Root.Level = minimumLevel;
                repositoryHierarchy.Configured = true;
            }
        }
    }
}
