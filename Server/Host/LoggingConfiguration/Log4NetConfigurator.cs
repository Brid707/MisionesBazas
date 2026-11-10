using log4net;
using log4net.Appender;
using log4net.Core;
using log4net.Layout;
using log4net.Repository.Hierarchy;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Host.LoggingConfiguration
{
    internal static class Log4NetConfigurator
    {
        private const string LogsDirectoryName = "Logs";
        private const string RollingFileAppenderName = "RollingFileAppender";
        private const string ConversionPatternText =
            "%date{yyyy-MM-dd HH:mm:ss.fff} [%thread] %-5level %logger - %message%newline%exception";
        private const string RollingDatePatternText = "_yyyy-MM-dd'.log'";
        private const string MaximumFileSizeText = "10MB";
        private const int MaximumRollBackupsCount = 10;

        public static void Configure(string logFileName)
        {
            if (string.IsNullOrWhiteSpace(logFileName))
            {
                throw new ArgumentException("Log file name must not be null or whitespace.", nameof(logFileName));
            }

            Hierarchy repositoryHierarchy = (Hierarchy)LogManager.GetRepository();

            if (!repositoryHierarchy.Configured)
            {
                PatternLayout patternLayout = new PatternLayout
                {
                    ConversionPattern = ConversionPatternText
                };
                patternLayout.ActivateOptions();

                string logFilePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, LogsDirectoryName, 
                    logFileName);
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
                repositoryHierarchy.Root.Level = Level.Info;
                repositoryHierarchy.Configured = true;
            }
        }
    }
}
