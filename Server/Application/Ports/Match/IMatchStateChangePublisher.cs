namespace Application.Ports
{
    /// <summary>Publishes public versions after scheduled mutations without exporting hands.</summary>
    public interface IMatchStateChangePublisher
    {
        void PublishMatchStateChange(string lobbyCode, long matchStateVersion);
    }
}
