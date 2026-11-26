using System;
using System.Configuration;
using System.ServiceModel;
using System.Threading.Tasks;
using Model.PlayerProfileService;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Model.Services
{
    /// <summary>Uses bounded protected WCF calls and reports uncertain writes without automatic resubmission.</summary>
    public sealed class PlayerProfileClient : IPlayerProfileClient
    {
        private const string EndpointConfigurationName = "PlayerProfileEndpoint";
        private const string ConnectionFailureTemplate = "Profile connection failed with {ExceptionType}.";
        private readonly ILoggerService _logger;

        public PlayerProfileClient(ILoggerService logger)
        {
            _logger = logger;
        }

        public Task<PlayerProfileClientResult> GetOwnProfileAsync(string accountSessionToken)
        {
            return Task.Run(() => Execute(service => service.GetOwnProfile(accountSessionToken), CreateReadResult,
                false));
        }

        public Task<PlayerProfileClientResult> UpdateOwnBiographyAsync(ProfileBiographyUpdate biographyUpdate)
        {
            return Task.Run(() => Execute(service => service.UpdateOwnBiography(biographyUpdate), CreateWriteResult,
                true));
        }

        private PlayerProfileClientResult Execute<T>(Func<IPlayerProfileService, T> operation,
            Func<T, PlayerProfileClientResult> createResult, bool isWriteOperation)
        {
            ChannelFactory<IPlayerProfileService> channelFactory = null;
            IClientChannel channel = null;
            PlayerProfileClientResult operationResult;
            try
            {
                channelFactory = new ChannelFactory<IPlayerProfileService>(EndpointConfigurationName);
                IPlayerProfileService service = channelFactory.CreateChannel();
                channel = (IClientChannel)service;
                operationResult = createResult(operation(service));
            }
            catch (FaultException<PlayerProfileFault> ex)
            {
                operationResult = new PlayerProfileClientResult
                {
                    FailureReason = ex.Detail.FailureReason,
                    IsSaveUnconfirmed = isWriteOperation &&
                        ex.Detail.FailureReason == PlayerProfileFailureReason.ProfileUnavailable
                };
            }
            catch (CommunicationException ex)
            {
                operationResult = CreateConnectionFailure(ex);
            }
            catch (TimeoutException ex)
            {
                operationResult = CreateConnectionFailure(ex);
            }
            catch (ConfigurationErrorsException ex)
            {
                operationResult = CreateConnectionFailure(ex);
            }
            catch (InvalidOperationException ex)
            {
                operationResult = CreateConnectionFailure(ex);
            }
            finally
            {
                GameChannelCloser.CloseChannel(channel, _logger);
                GameChannelCloser.CloseChannel(channelFactory, _logger);
            }
            return operationResult;
        }

        private PlayerProfileClientResult CreateConnectionFailure(Exception failure)
        {
            _logger.Warning(ConnectionFailureTemplate, failure.GetType().Name);
            return new PlayerProfileClientResult
            {
                FailureReason = PlayerProfileFailureReason.ProfileUnavailable,
                IsSaveUnconfirmed = true
            };
        }

        private static PlayerProfileClientResult CreateReadResult(PlayerProfileDetails profile)
        {
            return new PlayerProfileClientResult { Profile = profile };
        }

        private static PlayerProfileClientResult CreateWriteResult(string biography)
        {
            return new PlayerProfileClientResult { SavedBiography = biography };
        }
    }
}
