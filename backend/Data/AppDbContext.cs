using Microsoft.EntityFrameworkCore;
using AabeDfwApiV2.Models;

namespace AabeDfwApiV2.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        // Add DbSets here as your models are created.
        // public DbSet<YourModel> YourModels { get; set; }
        public DbSet<Member> Members { get; set; }
        public DbSet<Committee> Committees { get; set; }
        public DbSet<Event> Events { get; set; }
        public DbSet<Signup> Signups { get; set; }
        public DbSet<Payment> Payments { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Event>()
            .HasOne(eventItem => eventItem.Committee)
            .WithMany()
            .HasForeignKey(eventItem => eventItem.CommitteeId);

            modelBuilder.Entity<Signup>()
            .HasOne(signup => signup.Member)
            .WithMany(member => member.Signups)
            .HasForeignKey(signup => signup.MemberId);

            modelBuilder.Entity<Signup>()
            .HasOne(signup => signup.Event)
            .WithMany(eventItem => eventItem.Signups)
            .HasForeignKey(signup => signup.EventId);

            modelBuilder.Entity<Payment>()
            .HasOne(payment => payment.Signup)
            .WithMany()
            .HasForeignKey(payment => payment.SignupId);

            modelBuilder.Entity<Event>()
            .Property(eventItem => eventItem.Price)
            .HasPrecision(10, 2);

            modelBuilder.Entity<Payment>()
            .Property(payment => payment.Amount)
            .HasPrecision(10, 2);
        }
    }
}