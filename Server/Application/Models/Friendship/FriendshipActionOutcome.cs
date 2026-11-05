namespace Application.Models.Friendship
{
    public sealed class FriendshipActionOutcome
    {
        public bool IsSuccess { get; set; }

        public string Message { get; set; }

        public int ErrorCode { get; set; }
    }
}
