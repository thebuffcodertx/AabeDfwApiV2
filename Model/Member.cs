namespace AabeDfwApiV2.Models
{
    public class Member
    {
        public int Id { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Email { get; set; }
        public DateTime JoinDate { get; set; }
        public ICollection<Signup> Signups { get; set; } = new List<Signup>();
    }
}