using System;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;

namespace Host.DependencyInjection
{
    /// <summary>
    /// Provides WCF service instances using a delegate factory to enable constructor dependency injection.
    /// </summary>
    /// <typeparam name="TService">The type of the WCF service to instantiate.</typeparam>
    public sealed class FuncInstanceProvider<TService> : IInstanceProvider
        where TService : class
    {
        private readonly Func<TService> _instanceFactory;

        public FuncInstanceProvider(Func<TService> instanceFactory)
        {
            if (instanceFactory == null)
            {
                throw new ArgumentNullException(nameof(instanceFactory));
            }

            _instanceFactory = instanceFactory;
        }

        public object GetInstance(InstanceContext instanceContext)
        {
            return _instanceFactory();
        }

        public object GetInstance(InstanceContext instanceContext, Message message)
        {
            return _instanceFactory();
        }

        public void ReleaseInstance(InstanceContext instanceContext, object instance)
        {
            IDisposable disposable = instance as IDisposable;
            if (disposable != null)
            {
                disposable.Dispose();
            }
        }
    }
}
