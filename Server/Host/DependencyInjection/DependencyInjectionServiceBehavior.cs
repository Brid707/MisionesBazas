using System;
using System.Collections.ObjectModel;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;

namespace Host.DependencyInjection
{
    /// <summary>
    /// Configures a WCF <see cref="ServiceHostBase"/> to resolve instances via an <see cref="IInstanceProvider"/>.
    /// </summary>
    public sealed class DependencyInjectionServiceBehavior : IServiceBehavior
    {
        private readonly IInstanceProvider _instanceProvider;

        public DependencyInjectionServiceBehavior(IInstanceProvider instanceProvider)
        {
            if (instanceProvider == null)
            {
                throw new ArgumentNullException(nameof(instanceProvider));
            }

            _instanceProvider = instanceProvider;
        }

        public void AddBindingParameters(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase,
            Collection<ServiceEndpoint> endpoints, BindingParameterCollection bindingParameters)
        {
        }

        public void ApplyDispatchBehavior(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
        {
            if (serviceHostBase == null)
            {
                throw new ArgumentNullException(nameof(serviceHostBase));
            }

            foreach (ChannelDispatcherBase channelDispatcherBase in serviceHostBase.ChannelDispatchers)
            {
                ChannelDispatcher channelDispatcher = channelDispatcherBase as ChannelDispatcher;
                if (channelDispatcher != null)
                {
                    foreach (EndpointDispatcher endpointDispatcher in channelDispatcher.Endpoints)
                    {
                        if (!endpointDispatcher.IsSystemEndpoint)
                        {
                            endpointDispatcher.DispatchRuntime.InstanceProvider = _instanceProvider;
                        }
                    }
                }
            }
        }

        public void Validate(ServiceDescription serviceDescription, ServiceHostBase serviceHostBase)
        {
        }
    }
}
