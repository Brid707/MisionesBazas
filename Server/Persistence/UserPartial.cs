namespace Persistence.Entities
{
    /// <summary>
    /// Partial class extension for the <see cref="User"/> entity to support non-persisted runtime properties.
    /// </summary>
    public partial class User
    {
        /// <summary>
        /// Gets or sets the ranking or lobby position of the user.
        /// </summary>
        public int Position { get; set; }
    }
}
