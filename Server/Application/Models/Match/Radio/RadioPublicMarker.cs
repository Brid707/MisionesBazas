namespace Application.Models
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    public enum RadioPublicMarker
    {
        None = 0,
        Highest = 1,
        Only = 2,
        Lowest = 3,
        Hidden = 4
    }
}
