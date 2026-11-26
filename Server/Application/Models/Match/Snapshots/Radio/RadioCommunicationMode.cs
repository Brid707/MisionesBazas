
namespace Application.Models
{
    /// <summary>Identifies radio communication state without carrying private hands.</summary>
    public enum RadioCommunicationMode
    {
        Standard = 0,
        Interference = 1,
        DisruptionUntilTrick2 = 2,
        DisruptionUntilTrick3 = 3
    }
}
