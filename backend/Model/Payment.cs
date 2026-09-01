namespace AabeDfwApiV2.Models
{
    public class Payment
    {
        public int Id { get; set; }
        public int SignupId { get; set; }
        public Signup? Signup { get; set; }
        public decimal Amount { get; set; }
        public string? StripePaymentIntentId { get; set; }
        public string? Status { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}