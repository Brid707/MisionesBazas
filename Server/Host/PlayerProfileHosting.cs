using System;
using System.ServiceModel;
using System.ServiceModel.Description;
using Application.Ports;
using Application.UseCases;
using Persistence.Repository;
using Services.Contracts;
using Services.Services;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Host
{
    internal static class PlayerProfileHosting
    {
        private const int MaximumConcurrentProfileCalls = 8;
        private const int MaximumConcurrentProfileSessions = 32;
        private const int MaximumProfileServiceInstances = 1;
        private const string ProfileBindingName = "PlayerProfileBinding";
        private const string ProfileEndpointAddress = "net.tcp://localhost:8090/PlayerProfileService";

        internal static ServiceHost Create(IAccountAccessPolicy accountAccessPolicy, ILoggerFactory loggerFactory)
        {
            var repository = new PlayerProfileRepository(loggerFactory.CreateLogger<PlayerProfileRepository>());
            var profileUseCase = new PlayerProfileUseCase(repository);
            var service = new PlayerProfileService(profileUseCase, accountAccessPolicy);
            var profileHost = new ServiceHost(service, new Uri(ProfileEndpointAddress));
            profileHost.AddServiceEndpoint(typeof(IPlayerProfileService), CreateBinding(), string.Empty);
            if (profileHost.Description.Behaviors.Find<ServiceMetadataBehavior>() == null)
            {
                profileHost.Description.Behaviors.Add(new ServiceMetadataBehavior { HttpGetEnabled = false });
            }
            profileHost.AddServiceEndpoint(ServiceMetadataBehavior.MexContractName,
                MetadataExchangeBindings.CreateMexTcpBinding(), "mex");
            profileHost.Description.Behaviors.Add(new ServiceThrottlingBehavior
            {
                MaxConcurrentCalls = MaximumConcurrentProfileCalls,
                MaxConcurrentSessions = MaximumConcurrentProfileSessions,
                MaxConcurrentInstances = MaximumProfileServiceInstances
            });
            return profileHost;
        }

        private static NetTcpBinding CreateBinding()
        {
            return new NetTcpBinding(ProfileBindingName);
        }
    }
}
