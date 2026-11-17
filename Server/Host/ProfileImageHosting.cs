using System;
using System.Configuration;
using System.IO;
using System.Net.Security;
using System.ServiceModel;
using System.ServiceModel.Description;
using Application.Models;
using Application.Ports;
using Application.UseCases;
using Infrastructure.ProfileImages;
using Persistence.Repository;
using ProfileImages;
using Services.Contracts;
using Services.Services;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Host
{
    internal static class ProfileImageHosting
    {
        internal static ServiceHost Create(IAccountAccessPolicy accountAccessPolicy, ILoggerFactory loggerFactory)
        {
            string storageDirectory = ConfigurationManager.AppSettings["ProfileImagesDirectory"];
            if (string.IsNullOrWhiteSpace(storageDirectory))
            {
                storageDirectory = Path.Combine(
                    Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
                    "MisionesBazas", "Server", "ProfileImages");
            }
            var useCase = new ProfileImageUseCase(
                new ProfileImageProcessor(),
                new FileProfileImageStorage(storageDirectory, loggerFactory.CreateLogger<FileProfileImageStorage>()),
                new PlayerProfileRepository(loggerFactory.CreateLogger<PlayerProfileRepository>()),
                loggerFactory.CreateLogger<ProfileImageUseCase>());
            var service = new ProfileImageService(
                useCase,
                accountAccessPolicy,
                loggerFactory.CreateLogger<ProfileImageService>());
            string endpointAddress = ConfigurationManager.AppSettings["ProfileImageEndpointAddress"] ??
                "net.tcp://localhost:8090/ProfileImageService";
            var host = new ServiceHost(service, new Uri(endpointAddress));
            var binding = new NetTcpBinding(SecurityMode.Transport)
            {
                MaxReceivedMessageSize = ProfileImageLimits.MaximumTransportMessageBytes,
                MaxBufferSize = ProfileImageLimits.MaximumTransportMessageBytes,
                SendTimeout = TimeSpan.FromSeconds(5),
                ReceiveTimeout = TimeSpan.FromMinutes(5)
            };
            binding.ReaderQuotas.MaxArrayLength = ProfileImageLimits.MaximumUploadBytes;
            binding.Security.Transport.ProtectionLevel = ProtectionLevel.EncryptAndSign;
            host.AddServiceEndpoint(typeof(IProfileImageService), binding, string.Empty);
            host.Description.Behaviors.Add(new ServiceThrottlingBehavior
            {
                MaxConcurrentCalls = 8,
                MaxConcurrentSessions = 128,
                MaxConcurrentInstances = 1
            });
            return host;
        }
    }
}
