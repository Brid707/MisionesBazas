using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Resources;
using System.Threading;
using MisionesBazas.Properties;

namespace MisionesBazas
{
    public class LocalizationManager : INotifyPropertyChanged
    {
        private static LocalizationManager _instance;

        public static LocalizationManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new LocalizationManager();
                }
                return _instance;
            }
        }

        private static readonly Dictionary<string, ResourceManager> _resourceManagers =
            new Dictionary<string, ResourceManager>(StringComparer.OrdinalIgnoreCase);

        static LocalizationManager()
        {
            try
            {
                var asm = typeof(LocalizationManager).Assembly;
                _resourceManagers["es-MX"] = new ResourceManager("MisionesBazas.Properties.Resources.es-MX", asm);
                _resourceManagers["es"] = new ResourceManager("MisionesBazas.Properties.Resources.es-MX", asm);
                _resourceManagers["en-US"] = new ResourceManager("MisionesBazas.Properties.Resources.en-US", asm);
                _resourceManagers["en"] = new ResourceManager("MisionesBazas.Properties.Resources.en-US", asm);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"[LocalizationManager] Error initializing ResourceManagers: {ex.Message}");
            }
        }

        private CultureInfo _currentCulture;
        private ResourceManager _activeResourceManager;

        public CultureInfo CurrentCulture
        {
            get => _currentCulture ?? Thread.CurrentThread.CurrentUICulture;
            private set
            {
                _currentCulture = value;
                if (value != null && (_resourceManagers.TryGetValue(value.Name, out var rm) || _resourceManagers.TryGetValue(value.TwoLetterISOLanguageName, out rm)))
                {
                    _activeResourceManager = rm;
                }
                else
                {
                    _activeResourceManager = Resources.ResourceManager;
                }
            }
        }

        public LocalizationManager()
        {
            _instance = this;
            CurrentCulture = Thread.CurrentThread.CurrentUICulture;
        }

        private static readonly Dictionary<string, string> _legacyKeyMap =
            new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
            {
                { "WindowTitle", "MainWindow.Title" },
                { "GameTitle", "HomeScreen.Title" },
                { "BtnLanguage", "HomeScreen.LanguageButton" },
                { "HomePage_BtnSignUp", "HomeScreen.SignUpButton" },
                { "HomePage_BtnLogin", "HomeScreen.LoginButton" },
                { "HomePage_BtnGuest", "HomeScreen.GuestButton" },
                { "SelectLanguage_Title", "SelectLanguage.Title" },
                { "SelectLanguage_BtnSpanish", "SelectLanguage.SpanishButton" },
                { "SelectLanguage_BtnEnglish", "SelectLanguage.EnglishButton" },
                { "SignUpScreen_Title", "Register.Title" },
                { "SignUpScreen_Restrictions", "Register.Restrictions" },
                { "SignUpScreen_TxtCorreo", "Register.Email" },
                { "SignUpScreen_TxtUsuario", "Register.Username" },
                { "SignUpScreen_TxtPassword", "Register.Password" },
                { "SignUpScreen_ConfirmPassword", "Register.ConfirmPassword" },
                { "SignUpScreen_Button", "Register.SubmitButton" },
                { "LblEmptyEmail", "Register.EmptyEmail" },
                { "LblEmptyUsername", "Register.EmptyUsername" },
                { "LblEmptyPassword", "Register.EmptyPassword" },
                { "LblEmptyPasswordConfirmation", "Register.EmptyPasswordConfirmation" },
                { "Register_ErrorPasswordMatch", "Register.PasswordMismatch" },
                { "Register_Success", "Register.Success" },
                { "Register_ErrorInvalidEmail", "Register.InvalidEmail" },
                { "Register_ErrorEmailAlreadyRegistered", "Register.EmailAlreadyRegistered" },
                { "Register_ErrorUsernameAlreadyRegistered", "Register.UsernameAlreadyRegistered" },
                { "Register_PasswordRule_Length", "Register.PasswordRuleLength" },
                { "Register_PasswordRule_SpecialChar", "Register.PasswordRuleSpecialChar" },
                { "Register_PasswordRule_Number", "Register.PasswordRuleNumber" },
                { "PantallaInicioSesion.Titulo", "Login.Title" },
                { "PantallaInicioSesion.TituloInicioSesion", "Login.LoginTitle" },
                { "PantallaInicioSesion.Correo", "Login.Email" },
                { "PantallaInicioSesion.Contraseña", "Login.Password" },
                { "PantallaInicioSesion.Entrar", "Login.Enter" },
                { "PantallaInicioSesion.RecuperarContraseña", "Login.ForgotPassword" },
                { "PantallaInicioSesion.CorreoVacio", "Login.EmptyEmail" },
                { "PantallaInicioSesion.ContraseñaVacia", "Login.EmptyPassword" },
                { "PantallaInicioSesion.CredencialesInvalidas", "Login.InvalidCredentials" },
                { "MenuJuego.CrearSala", "GameMenu.CreateRoom" },
                { "MenuJuego.UnirseSala", "GameMenu.JoinRoom" },
                { "MenuJuego.ComoJugar", "GameMenu.HowToPlay" },
                { "MenuJuego.EnLinea", "FriendsBar.Online" },
                { "MenuJuego.Desconectado", "FriendsBar.Offline" },
                { "MenuJuego.EliminarAmigo", "FriendsBar.DeleteFriend" },
                { "MenuJuego.VerPerfil", "FriendsBar.ViewProfile" },
                { "MenuJuego.InvitacionPartida", "FriendsBar.GameInvitation" },
                { "MenuJuego.InformacionPartida", "FriendsBar.GameInformation" },
                { "BarraAmigos.EnLinea", "FriendsBar.Online" },
                { "BarraAmigos.Desconectado", "FriendsBar.Offline" },
                { "BarraAmigos.EliminarAmigo", "FriendsBar.DeleteFriend" },
                { "BarraAmigos.VerPerfil", "FriendsBar.ViewProfile" },
                { "BarraAmigos.InvitacionPartida", "FriendsBar.GameInvitation" },
                { "BarraAmigos.InformacionPartida", "FriendsBar.GameInformation" },
                { "Perfil.CreacionCuenta", "Profile.AccountCreation" },
                { "Perfil.Fecha", "Profile.Date" },
                { "Perfil.Misiones", "Profile.Missions" },
                { "Perfil.Biografia", "Profile.Biography" },
                { "Perfil.Correo", "Profile.Email" }
            };

        public string this[string key]
        {
            get
            {
                string val = ResolveString(_activeResourceManager, key);
                if (string.IsNullOrEmpty(val))
                {
                    val = ResolveString(Resources.ResourceManager, key);
                }

                string result = val ?? $"[{key}]";
                return result;
            }
        }

        private string ResolveString(ResourceManager resourceManager, string key)
        {
            string resolved = null;
            if (resourceManager != null && !string.IsNullOrEmpty(key))
            {
                try
                {
                    resolved = resourceManager.GetString(key, CurrentCulture);
                    if (string.IsNullOrEmpty(resolved) && _legacyKeyMap.TryGetValue(key, out string modernKey))
                    {
                        resolved = resourceManager.GetString(modernKey, CurrentCulture);
                    }
                    if (string.IsNullOrEmpty(resolved) && key.Contains("."))
                    {
                        resolved = resourceManager.GetString(key.Replace('.', '_'), CurrentCulture);
                    }
                    if (string.IsNullOrEmpty(resolved) && key.Contains("_"))
                    {
                        resolved = resourceManager.GetString(key.Replace('_', '.'), CurrentCulture);
                    }
                }
                catch
                {
                    resolved = null;
                }
            }
            return resolved;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        /// <summary>
        /// Cambia la cultura actual de la aplicación y notifica a la interfaz para que actualice todos los textos.
        /// </summary>
        public void SetCulture(string cultureName)
        {
            if (!string.IsNullOrWhiteSpace(cultureName))
            {
                try
                {
                    var culture = new CultureInfo(cultureName);
                    CurrentCulture = culture;

                    CultureInfo.DefaultThreadCurrentUICulture = culture;
                    CultureInfo.DefaultThreadCurrentCulture = culture;
                    Thread.CurrentThread.CurrentUICulture = culture;
                    Thread.CurrentThread.CurrentCulture = culture;

                    try
                    {
                        Resources.Culture = culture;
                    }
                    catch { }
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(string.Empty));
                    PropertyChanged?.Invoke(this, new PropertyChangedEventArgs("Item[]"));
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"[LocalizationManager] Error setting culture '{cultureName}': {ex.Message}");
                }
            }
        }
    }
}
