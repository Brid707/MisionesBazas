using Application.Models.Friendship;
using Application.Ports;
using Persistence.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Persistence.Repository
{
    public sealed class FriendshipRepository : IFriendshipRepository
    {
        private const byte PendingFriendshipStatus = 1;
        private const byte AcceptedFriendshipStatus = 2;
        private const byte OnlineUserStatus = 1;
        private const string BlockPlayerDbUpdateFailureTemplate =
    "Database update failed while blocking player {BlockedId} by blocker {BlockerId}.";
        private const string BlockPlayerEntityFailureTemplate =
            "Entity Framework connection failed while blocking player {BlockedId} by blocker {BlockerId}.";
        private const string BlockPlayerSqlFailureTemplate =
            "SQL execution failed while blocking player {BlockedId} by blocker {BlockerId}.";

        private const string CreateFriendRequestDbUpdateFailureTemplate =
            "Database update failed while creating friend request from user {SenderUserId} to user {ReceiverUserId}.";
        private const string CreateFriendRequestEntityFailureTemplate =
            "Entity Framework connection failed while creating friend request from user {SenderUserId} to " +
            "user {ReceiverUserId}.";
        private const string CreateFriendRequestSqlFailureTemplate =
            "SQL execution failed while inserting friend request from user {SenderUserId} to user {ReceiverUserId}.";

        private const string DeleteFriendshipDbUpdateFailureTemplate =
            "Database update failed while deleting friendship between user {FirstUserId} and user {SecondUserId}.";
        private const string DeleteFriendshipEntityFailureTemplate =
            "Entity Framework connection failed while deleting friendship between user {FirstUserId} and " +
            "user {SecondUserId}.";
        private const string DeleteFriendshipSqlFailureTemplate =
            "SQL execution failed while executing friendship deletion between user {FirstUserId} and " +
            "user {SecondUserId}.";

        private const string GetFriendshipEntityFailureTemplate =
            "Entity Framework connection failed while querying friendship record between user {FirstUserId} and " +
            "user {SecondUserId}.";
        private const string GetFriendshipSqlFailureTemplate =
            "SQL execution failed while querying friendship record between user {FirstUserId} and " +
            "user {SecondUserId}.";

        private const string GetFriendsListEntityFailureTemplate =
            "Entity Framework connection failed while querying friends list for user {UserId}.";
        private const string GetFriendsListSqlFailureTemplate =
            "SQL execution failed while querying friends list in database for user {UserId}.";

        private const string GetPendingRequestsEntityFailureTemplate =
            "Entity Framework connection failed while querying pending friend requests for user {UserId}.";
        private const string GetPendingRequestsSqlFailureTemplate =
            "SQL execution failed while querying pending friend requests for user {UserId}.";

        private const string GetSentRequestsEntityFailureTemplate =
            "Entity Framework connection failed while querying sent friend requests for user {UserId}.";
        private const string GetSentRequestsSqlFailureTemplate =
            "SQL execution failed while querying sent friend requests for user {UserId}.";

        private const string IsPlayerBlockedEntityFailureTemplate =
            "Entity Framework connection failed while querying player block status between user {PlayerAId} and " +
            "user {PlayerBId}.";
        private const string IsPlayerBlockedSqlFailureTemplate =
            "SQL execution failed while querying player block status between user {PlayerAId} and user {PlayerBId}.";

        private const string RemoveFriendshipDbUpdateFailureTemplate =
            "Database update failed while removing friendship between user {FirstUserId} and user {SecondUserId}.";
        private const string RemoveFriendshipEntityFailureTemplate =
            "Entity Framework connection failed while removing friendship between user {FirstUserId} and " +
            "user {SecondUserId}.";
        private const string RemoveFriendshipSqlFailureTemplate =
            "SQL execution failed while removing friendship in database between user {FirstUserId} and " +
            "user {SecondUserId}.";

        private const string UnblockPlayerDbUpdateFailureTemplate =
            "Database update failed while removing player block for {BlockedId} by blocker {BlockerId}.";
        private const string UnblockPlayerEntityFailureTemplate =
            "Entity Framework connection failed while removing player block for {BlockedId} by blocker {BlockerId}.";
        private const string UnblockPlayerSqlFailureTemplate =
            "SQL execution failed while executing unblock operation for {BlockedId} by blocker {BlockerId}.";

        private const string UpdateFriendshipStatusDbUpdateFailureTemplate =
            "Database update failed while updating friendship status to {Status} between user {FirstUserId} and " +
            "user {SecondUserId}.";
        private const string UpdateFriendshipStatusEntityFailureTemplate =
            "Entity Framework connection failed while updating friendship status to {Status} between " +
            "user {FirstUserId} and user {SecondUserId}.";
        private const string UpdateFriendshipStatusSqlFailureTemplate =
            "SQL execution failed while executing friendship status update to {Status} between " +
            "user {FirstUserId} and user {SecondUserId}.";

        private const string DatabaseConnectionFailureMessage = "Failed to connect to the database.";
        private const string SavePlayerBlockFailureMessage = "Failed to save player block in the database.";
        private const string ExecuteBlockOperationFailureMessage = "Failed to execute block operation in the database.";
        private const string CreateFriendRequestFailureMessage = "Failed to create friend request in the database.";
        private const string InsertFriendRequestFailureMessage = "Failed to insert friend request in the database.";
        private const string DeleteFriendshipFailureMessage = "Failed to delete friendship from the database.";
        private const string ExecuteFriendshipDeletionFailureMessage =
            "Failed to execute friendship deletion in the database.";
        private const string QueryFriendshipRecordFailureMessage =
            "Failed to query friendship record in the database.";
        private const string QueryFriendsListFailureMessage = "Failed to query friends list in the database.";
        private const string QueryPendingRequestsFailureMessage = "Failed to query pending friend requests.";
        private const string QuerySentRequestsFailureMessage = "Failed to query sent friend requests.";
        private const string QueryPlayerBlockStatusFailureMessage = "Failed to query player block status.";
        private const string RemoveFriendshipFailureMessage = "Failed to remove friendship from the database.";
        private const string ExecuteFriendshipRemovalFailureMessage =
            "Failed to execute friendship removal in the database.";
        private const string RemovePlayerBlockFailureMessage = "Failed to remove player block from the database.";
        private const string ExecuteUnblockOperationFailureMessage =
            "Failed to execute unblock operation in the database.";
        private const string UpdateFriendshipStatusFailureMessage =
            "Failed to update friendship status in the database.";
        private const string ExecuteStatusUpdateFailureMessage = "Failed to execute status update in the database.";

        private readonly ILoggerService _logger;

        public FriendshipRepository(ILoggerService logger)
        {
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public void BlockPlayer(int blockerId, int blockedId)
        {
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    PlayerBlock existingBlock = context.PlayerBlock.Find(blockerId, blockedId);
                    if (existingBlock == null)
                    {
                        PlayerBlock newBlock = new PlayerBlock
                        {
                            IdBlockerUser = blockerId,
                            IdBlockedUser = blockedId,
                            CreatedAt = DateTime.UtcNow
                        };
                        context.PlayerBlock.Add(newBlock);
                    }
                    RemoveExistingFriendshipInContext(context, blockerId, blockedId);
                    context.SaveChanges();
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, BlockPlayerDbUpdateFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(SavePlayerBlockFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, BlockPlayerEntityFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, BlockPlayerSqlFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(ExecuteBlockOperationFailureMessage, ex);
            }
        }

        public async Task CreateFriendRequestAsync(int senderUserId, int receiverUserId)
        {
            int idUserLow = Math.Min(senderUserId, receiverUserId);
            int idUserHigh = Math.Max(senderUserId, receiverUserId);
            bool isRequestedByLow = senderUserId == idUserLow;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    Friendship newFriendship = new Friendship
                    {
                        IdUserLow = idUserLow,
                        IdUserHigh = idUserHigh,
                        RequestedByLow = isRequestedByLow,
                        Status = PendingFriendshipStatus,
                        RequestedAt = DateTime.UtcNow,
                        RespondedAt = null
                    };

                    context.Friendship.Add(newFriendship);
                    await context.SaveChangesAsync();
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, CreateFriendRequestDbUpdateFailureTemplate, senderUserId, receiverUserId);
                throw new InvalidOperationException(CreateFriendRequestFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, CreateFriendRequestEntityFailureTemplate, senderUserId, receiverUserId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, CreateFriendRequestSqlFailureTemplate, senderUserId, receiverUserId);
                throw new InvalidOperationException(InsertFriendRequestFailureMessage, ex);
            }
        }

        public async Task DeleteFriendshipAsync(int firstUserId, int secondUserId)
        {
            int idUserLow = Math.Min(firstUserId, secondUserId);
            int idUserHigh = Math.Max(firstUserId, secondUserId);
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    Friendship entity = await context.Friendship.FindAsync(idUserLow, idUserHigh);
                    if (entity != null)
                    {
                        context.Friendship.Remove(entity);
                        await context.SaveChangesAsync();
                    }
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, DeleteFriendshipDbUpdateFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(DeleteFriendshipFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, DeleteFriendshipEntityFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, DeleteFriendshipSqlFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(ExecuteFriendshipDeletionFailureMessage, ex);
            }
        }

        public async Task<FriendshipRecordData> GetFriendshipAsync(int firstUserId, int secondUserId)
        {
            FriendshipRecordData recordData = null;
            int idUserLow = Math.Min(firstUserId, secondUserId);
            int idUserHigh = Math.Max(firstUserId, secondUserId);
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    Friendship entity = await context.Friendship.FindAsync(idUserLow, idUserHigh);
                    if (entity != null)
                    {
                        recordData = MapToFriendshipRecordData(entity);
                    }
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, GetFriendshipEntityFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetFriendshipSqlFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(QueryFriendshipRecordFailureMessage, ex);
            }

            return recordData;
        }

        public List<FriendSummaryData> GetFriendsListByUserId(int userId)
        {
            List<FriendSummaryData> friends = new List<FriendSummaryData>();

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<Friendship> query =
                        from friendship in context.Friendship.Include("User").Include("User1")
                        where friendship.Status == AcceptedFriendshipStatus
                            && (friendship.IdUserLow == userId || friendship.IdUserHigh == userId)
                        select friendship;

                    List<Friendship> entities = query.ToList();
                    foreach (Friendship entity in entities)
                    {
                        friends.Add(MapToFriendSummary(entity, userId));
                    }
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, GetFriendsListEntityFailureTemplate, userId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetFriendsListSqlFailureTemplate, userId);
                throw new InvalidOperationException(QueryFriendsListFailureMessage, ex);
            }

            return friends;
        }

        public async Task<List<FriendRequestData>> GetPendingFriendRequestsByUserIdAsync(int userId)
        {
            List<FriendRequestData> pendingRequests = new List<FriendRequestData>();
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<Friendship> query =
                        from friendship in context.Friendship.Include("User").Include("User1")
                        where friendship.Status == PendingFriendshipStatus
                            && ((friendship.IdUserLow == userId && !friendship.RequestedByLow)
                                || (friendship.IdUserHigh == userId && friendship.RequestedByLow))
                        select friendship;

                    List<Friendship> entities = await query.ToListAsync();
                    foreach (Friendship entity in entities)
                    {
                        pendingRequests.Add(MapToFriendRequestData(entity));
                    }
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, GetPendingRequestsEntityFailureTemplate, userId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetPendingRequestsSqlFailureTemplate, userId);
                throw new InvalidOperationException(QueryPendingRequestsFailureMessage, ex);
            }

            return pendingRequests;
        }

        public async Task<List<FriendRequestData>> GetSentFriendRequestsByUserIdAsync(int userId)
        {
            List<FriendRequestData> sentRequests = new List<FriendRequestData>();

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<Friendship> query =
                        from friendship in context.Friendship.Include("User").Include("User1")
                        where friendship.Status == PendingFriendshipStatus
                            && ((friendship.IdUserLow == userId && friendship.RequestedByLow)
                                || (friendship.IdUserHigh == userId && !friendship.RequestedByLow))
                        select friendship;

                    List<Friendship> entities = await query.ToListAsync();
                    foreach (Friendship entity in entities)
                    {
                        sentRequests.Add(MapToFriendRequestData(entity));
                    }
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, GetSentRequestsEntityFailureTemplate, userId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, GetSentRequestsSqlFailureTemplate, userId);
                throw new InvalidOperationException(QuerySentRequestsFailureMessage, ex);
            }

            return sentRequests;
        }

        public bool IsPlayerBlockedByPlayerA(int playerAId, int playerBId)
        {
            bool isBlocked = false;

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    IQueryable<PlayerBlock> query =
                        from block in context.PlayerBlock
                        where (block.IdBlockerUser == playerAId && block.IdBlockedUser == playerBId)
                            || (block.IdBlockerUser == playerBId && block.IdBlockedUser == playerAId)
                        select block;

                    PlayerBlock foundBlock = query.FirstOrDefault();
                    isBlocked = foundBlock != null;
                }
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, IsPlayerBlockedEntityFailureTemplate, playerAId, playerBId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, IsPlayerBlockedSqlFailureTemplate, playerAId, playerBId);
                throw new InvalidOperationException(QueryPlayerBlockStatusFailureMessage, ex);
            }

            return isBlocked;
        }

        public void RemoveFriendship(int firstUserId, int secondUserId)
        {
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    RemoveExistingFriendshipInContext(context, firstUserId, secondUserId);
                    context.SaveChanges();
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, RemoveFriendshipDbUpdateFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(RemoveFriendshipFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, RemoveFriendshipEntityFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, RemoveFriendshipSqlFailureTemplate, firstUserId, secondUserId);
                throw new InvalidOperationException(ExecuteFriendshipRemovalFailureMessage, ex);
            }
        }

        public void UnblockPlayer(int blockerId, int blockedId)
        {
            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    PlayerBlock existingBlock = context.PlayerBlock.Find(blockerId, blockedId);
                    if (existingBlock != null)
                    {
                        context.PlayerBlock.Remove(existingBlock);
                        context.SaveChanges();
                    }
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, UnblockPlayerDbUpdateFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(RemovePlayerBlockFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, UnblockPlayerEntityFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, UnblockPlayerSqlFailureTemplate, blockedId, blockerId);
                throw new InvalidOperationException(ExecuteUnblockOperationFailureMessage, ex);
            }
        }

        public async Task UpdateFriendshipStatusAsync(int firstUserId, int secondUserId, byte status)
        {
            int idUserLow = Math.Min(firstUserId, secondUserId);
            int idUserHigh = Math.Max(firstUserId, secondUserId);

            try
            {
                using (TrickTakingMissionsBDEntities context = new TrickTakingMissionsBDEntities())
                {
                    Friendship entity = await context.Friendship.FindAsync(idUserLow, idUserHigh);
                    if (entity != null)
                    {
                        entity.Status = status;
                        entity.RespondedAt = DateTime.UtcNow;
                        await context.SaveChangesAsync();
                    }
                }
            }
            catch (DbUpdateException ex)
            {
                _logger.Error(ex, UpdateFriendshipStatusDbUpdateFailureTemplate, status, firstUserId, secondUserId);
                throw new InvalidOperationException(UpdateFriendshipStatusFailureMessage, ex);
            }
            catch (EntityException ex)
            {
                _logger.Error(ex, UpdateFriendshipStatusEntityFailureTemplate, status, firstUserId, secondUserId);
                throw new InvalidOperationException(DatabaseConnectionFailureMessage, ex);
            }
            catch (SqlException ex)
            {
                _logger.Error(ex, UpdateFriendshipStatusSqlFailureTemplate, status, firstUserId, secondUserId);
                throw new InvalidOperationException(ExecuteStatusUpdateFailureMessage, ex);
            }
        }

        private static FriendSummaryData MapToFriendSummary(Friendship entity, int currentUserId)
        {
            User friendUser = entity.IdUserLow == currentUserId
                ? entity.User1
                : entity.User;

            return new FriendSummaryData
            {
                IdUser = friendUser.IdUser,
                Username = friendUser.Username,
                IsOnline = friendUser.Status == OnlineUserStatus
            };
        }

        private static FriendRequestData MapToFriendRequestData(Friendship entity)
        {
            User senderUser = entity.RequestedByLow
                ? entity.User
                : entity.User1;
            User receiverUser = entity.RequestedByLow
                ? entity.User1
                : entity.User;

            return new FriendRequestData
            {
                SenderIdUser = senderUser.IdUser,
                SenderUsername = senderUser.Username,
                ReceiverIdUser = receiverUser.IdUser,
                ReceiverUsername = receiverUser.Username,
                Status = entity.Status,
                RequestDate = entity.RequestedAt
            };
        }

        private static FriendshipRecordData MapToFriendshipRecordData(Friendship entity)
        {
            return new FriendshipRecordData
            {
                IdUserLow = entity.IdUserLow,
                IdUserHigh = entity.IdUserHigh,
                Status = entity.Status,
                IsRequestedByLow = entity.RequestedByLow,
                RequestedAt = entity.RequestedAt,
                RespondedAt = entity.RespondedAt
            };
        }

        private static void RemoveExistingFriendshipInContext(TrickTakingMissionsBDEntities context,
            int firstUserId, int secondUserId)
        {
            int idUserLow = Math.Min(firstUserId, secondUserId);
            int idUserHigh = Math.Max(firstUserId, secondUserId);
            Friendship existingFriendship = context.Friendship.Find(idUserLow, idUserHigh);

            if (existingFriendship != null)
            {
                context.Friendship.Remove(existingFriendship);
            }
        }
    }
}
