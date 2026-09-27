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
        public App()
        {
            LocalizationManager.Instance.SetCulture("es-MX");

            InitializeComponent();
        }

        public static void ChangeLanguage(string language)
        {
            if (string.IsNullOrWhiteSpace(language)) return;

            LocalizationManager.Instance.SetCulture(language);
        }
    }
}
