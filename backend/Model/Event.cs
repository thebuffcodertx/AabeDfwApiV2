namespace AabeDfwApiV2.Models
{
    public class Event
    {
        public int Id { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? ImageUrl { get; set; }
        public DateTime EventDate { get; set; }
        public string? Location { get; set; }
        public decimal Price { get; set; }
        public int CommitteeId { get; set; }
        public Committee? Committee { get; set; }
        public ICollection<Signup> Signups { get; set; } = new List<Signup>();
    }
}