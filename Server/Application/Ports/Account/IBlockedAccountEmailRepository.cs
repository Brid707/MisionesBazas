namespace Application.Ports
{
    /// <summary>Checks whether a normalized email has a durable permanent registration restriction.</summary>
    public interface IBlockedAccountEmailRepository
    {
        /// <summary>Checks the durable restriction using the server's email normalization policy.</summary>
        /// <param name="accountEmail">The registration email to evaluate.</param>
        /// <returns>True when permanent registration is blocked for this normalized email.</returns>
        bool IsAccountEmailPermanentlyBlocked(string accountEmail);
    }
}
