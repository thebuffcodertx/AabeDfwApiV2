namespace AabeDfwApiV2.Models
{
    public class Signup
    {
        public int Id { get; set; }
        public int MemberId { get; set; }
        public Member? Member { get; set; }
        public int EventId { get; set; }
        public Event? Event { get; set; }
        public DateTime SignupDate { get; set; }
        public bool PaymentCompleted { get; set; }
    }
}