using Application.Models;
using Application.Models.Friendship;
using Application.Ports;
using Application.UseCases;
using NSubstitute;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Server.Application.Tests.UseCases.Friendship
{
    [TestFixture]
    public sealed class TestsFriendshipUseCase
    {
        private IFriendshipRepository _friendshipRepository;
        private IUserRepository _userRepository;
        private ILoggerService _loggerService;
        private FriendshipUseCase _friendshipUseCase;

        [SetUp]
        public void SetUp()
        {
            _friendshipRepository = Substitute.For<IFriendshipRepository>();
            _userRepository = Substitute.For<IUserRepository>();
            _loggerService = Substitute.For<ILoggerService>();

            _friendshipUseCase = new FriendshipUseCase(_friendshipRepository, _userRepository, _loggerService);
        }

        [Test]
        public async Task SendFriendRequestAsync_ValidParameters_ReturnsSuccess()
        {
            const int senderUserId = 1;
            const int receiverUserId = 2;
            const string targetUsername = "Bri";
            UserAccount targetAccount = new UserAccount
            {
                IdUser = receiverUserId,
                Username = targetUsername
            };
            _userRepository.GetUserByUsername(targetUsername).Returns(targetAccount);
            _friendshipRepository.IsPlayerBlockedByPlayerA(senderUserId, targetAccount.IdUser).Returns(false);

            FriendshipActionOutcome friendshipActionOutcome = await
                _friendshipUseCase.SendFriendRequestAsync(senderUserId, targetUsername);

            Assert.That(friendshipActionOutcome.IsSuccess, Is.True);
        }


        [Test]
        public async Task SendFriendRequestAsync_NegativeSenderUserId_ReturnsValidationErrorCode()
        {
            const int invalidadUserId = -1;
            const int validationFailedErrorCode = 101;
            const string targetUsername = "Bri";

            FriendshipActionOutcome friendshipActionOutcome = await
                _friendshipUseCase.SendFriendRequestAsync(invalidadUserId, targetUsername);

            Assert.That(friendshipActionOutcome.ErrorCode, Is.EqualTo(validationFailedErrorCode));
        }

        [Test]
        public async Task SendFriendRequestAsync_NonExistentTargetUsername_ReturnsUserNotFoundErrorCode()
        {
            const int senderUserId = 1;
            const int userNotFoundErrorCode = 102;
            const string nonExistingTargetUsername = "NonExistingUser";
            _userRepository.GetUserByUsername(nonExistingTargetUsername).Returns((UserAccount)null);

            FriendshipActionOutcome friendshipActionOutcome = await
                _friendshipUseCase.SendFriendRequestAsync(senderUserId, nonExistingTargetUsername);

            Assert.That(friendshipActionOutcome.ErrorCode, Is.EqualTo(userNotFoundErrorCode));
        }


        [Test]
        public void BlockPlayer_RepositoryThrowsInvalidOperation_ReturnsPersistanceFailureErrorCode()
        {
            const int blockerUserId = 1;
            const int targetUserId = 2;
            const int persistanceFailureErrorCode = 201;
            _friendshipRepository.When(friendshipRepository
                => friendshipRepository.BlockPlayer(blockerUserId, targetUserId)).Throw<InvalidOperationException>();

            FriendshipActionOutcome friendshipActionOutcome = _friendshipUseCase.BlockPlayer(blockerUserId,
                targetUserId);

            Assert.That(friendshipActionOutcome.ErrorCode, Is.EqualTo(persistanceFailureErrorCode));
        }
    }
}
