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

namespace Persistence.Repository
{
    public sealed class FriendshipRepository : IFriendshipRepository
    {
        private const byte PendingFriendshipStatus = 1;
        private const byte AcceptedFriendshipStatus = 2;
        private const byte OnlineUserStatus = 1;

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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to save player block in the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute block operation in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to create friend request in the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to insert friend request in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to delete friendship from the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute friendship deletion in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to query friendship record in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to query friends list in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to query pending friend requests.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to query sent friend requests.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to query player block status.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to remove friendship from the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute friendship removal in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to remove player block from the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute unblock operation in the database.", ex);
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
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to update friendship status in the database.", ex);
            }
            catch (EntityException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to connect to the database.", ex);
            }
            catch (SqlException ex)
            {
                // TODO: Implement logging for the exception once logging infrastructure is available.
                throw new InvalidOperationException("Failed to execute status update in the database.", ex);
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
