using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Globalization;
using System.Threading;

namespace MisionesBazas
{
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            var languageCode = MisionesBazas.Properties.Settings.Default.languageCode;
            if (!string.IsNullOrEmpty(languageCode))
            {
                var culture = new System.Globalization.CultureInfo(languageCode);
                Thread.CurrentThread.CurrentCulture = culture;
                Thread.CurrentThread.CurrentUICulture = culture;
                System.Globalization.CultureInfo.DefaultThreadCurrentCulture = culture;
                System.Globalization.CultureInfo.DefaultThreadCurrentUICulture = culture;
                MisionesBazas.Properties.Langs.Resources.Culture = culture;
            }

            base.OnStartup(e);
        }
    }
}
