using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace ReadingChallengeWebApi.Models
{
    public partial class ReadingChallengeDBContext : DbContext
    {
        public ReadingChallengeDBContext()
        {
        }

        public ReadingChallengeDBContext(DbContextOptions<ReadingChallengeDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Authors> Authors { get; set; }
        public virtual DbSet<Books> Books { get; set; }
        public virtual DbSet<Challenge> Challenge { get; set; }
        public virtual DbSet<Challenges> Challenges { get; set; }
        public virtual DbSet<Genres> Genres { get; set; }
        public virtual DbSet<Organization> Organization { get; set; }
        public virtual DbSet<Organizations> Organizations { get; set; }
        public virtual DbSet<OrgUserChallenges> OrgUserChallenges { get; set; }
        public virtual DbSet<OrgUsers> OrgUsers { get; set; }
        public virtual DbSet<UserBooks> UserBooks { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=DESKTOP-79OEU72\\SQLEXPRESS;Database=ReadingChallengeDB;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Authors>(entity =>
            {
                entity.HasKey(e => e.AuthorId);

                entity.Property(e => e.AuthorId)
                    .HasColumnName("authorID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Name)
                    .HasColumnName("name")
                    .HasMaxLength(10);
            });

            modelBuilder.Entity<Books>(entity =>
            {
                entity.HasKey(e => e.BookId);

                entity.Property(e => e.BookId)
                    .HasColumnName("bookID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Author)
                    .HasColumnName("author")
                    .HasMaxLength(255);

                entity.Property(e => e.Pages).HasColumnName("pages");

                entity.Property(e => e.Title)
                    .HasColumnName("title")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Challenge>(entity =>
            {
                entity.Property(e => e.ChallengeId)
                    .HasColumnName("challengeID")
                    .ValueGeneratedNever();

                entity.Property(e => e.BeginDate)
                    .IsRequired()
                    .HasColumnName("beginDate")
                    .HasMaxLength(10);

                entity.Property(e => e.EndDate)
                    .IsRequired()
                    .HasColumnName("endDate")
                    .HasMaxLength(10);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(10);

                entity.Property(e => e.NumGoal)
                    .IsRequired()
                    .HasColumnName("numGoal")
                    .HasMaxLength(10);

                entity.Property(e => e.OrgId).HasColumnName("orgID");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasColumnName("type")
                    .HasMaxLength(10);

                entity.HasOne(d => d.Org)
                    .WithMany(p => p.Challenge)
                    .HasForeignKey(d => d.OrgId)
                    .HasConstraintName("FK__Challenge__orgID__398D8EEE");
            });

            modelBuilder.Entity<Challenges>(entity =>
            {
                entity.HasKey(e => e.ChallengeId);

                entity.Property(e => e.ChallengeId)
                    .HasColumnName("challengeID")
                    .ValueGeneratedNever();

                entity.Property(e => e.BeginDate)
                    .HasColumnName("beginDate")
                    .HasColumnType("date");

                entity.Property(e => e.EndDate)
                    .HasColumnName("endDate")
                    .HasColumnType("date");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(10);

                entity.Property(e => e.NumGoal).HasColumnName("numGoal");

                entity.Property(e => e.OrgId).HasColumnName("orgID");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasColumnName("type")
                    .HasMaxLength(10);

                entity.HasOne(d => d.Org)
                    .WithMany(p => p.Challenges)
                    .HasForeignKey(d => d.OrgId)
                    .HasConstraintName("FK__Challenge__orgID__440B1D61");
            });

            modelBuilder.Entity<Genres>(entity =>
            {
                entity.HasKey(e => e.GenreId);

                entity.Property(e => e.GenreId)
                    .HasColumnName("genreID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Name)
                    .HasColumnName("name")
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Organization>(entity =>
            {
                entity.HasKey(e => e.OrgId);

                entity.Property(e => e.OrgId)
                    .HasColumnName("orgID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Category)
                    .HasColumnName("category")
                    .HasMaxLength(10);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Organizations>(entity =>
            {
                entity.HasKey(e => e.OrgId);

                entity.Property(e => e.OrgId)
                    .HasColumnName("orgID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Category)
                    .HasColumnName("category")
                    .HasMaxLength(10);

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasColumnName("name")
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<OrgUserChallenges>(entity =>
            {
                entity.HasKey(e => e.OrgUserChallengeId);

                entity.Property(e => e.OrgUserChallengeId)
                    .HasColumnName("orgUserChallengeID")
                    .ValueGeneratedNever();

                entity.Property(e => e.OrgUserId).HasColumnName("orgUserID");

                entity.Property(e => e.UserId).HasColumnName("userID");

                entity.HasOne(d => d.OrgUser)
                    .WithMany(p => p.OrgUserChallenges)
                    .HasForeignKey(d => d.OrgUserId)
                    .HasConstraintName("FK__OrgUserCh__orgUs__5165187F");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.OrgUserChallenges)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__OrgUserCh__userI__52593CB8");
            });

            modelBuilder.Entity<OrgUsers>(entity =>
            {
                entity.HasKey(e => e.OrgUserId);

                entity.Property(e => e.OrgUserId)
                    .HasColumnName("orgUserID")
                    .ValueGeneratedNever();

                entity.Property(e => e.ChallengeId).HasColumnName("challengeID");

                entity.Property(e => e.OrgId).HasColumnName("orgID");

                entity.HasOne(d => d.Challenge)
                    .WithMany(p => p.OrgUsers)
                    .HasForeignKey(d => d.ChallengeId)
                    .HasConstraintName("FK__OrgUsers__challe__5070F446");

                entity.HasOne(d => d.Org)
                    .WithMany(p => p.OrgUsers)
                    .HasForeignKey(d => d.OrgId)
                    .HasConstraintName("FK__OrgUsers__orgID__44FF419A");
            });

            modelBuilder.Entity<UserBooks>(entity =>
            {
                entity.HasKey(e => e.UserBookId);

                entity.Property(e => e.UserBookId)
                    .HasColumnName("userBookID")
                    .ValueGeneratedNever();

                entity.Property(e => e.BookId).HasColumnName("bookID");

                entity.Property(e => e.UserId).HasColumnName("userID");

                entity.HasOne(d => d.Book)
                    .WithMany(p => p.UserBooks)
                    .HasForeignKey(d => d.BookId)
                    .HasConstraintName("FK__UserBooks__bookI__534D60F1");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserBooks)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__UserBooks__userI__5441852A");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId);

                entity.Property(e => e.UserId)
                    .HasColumnName("userID")
                    .ValueGeneratedNever();

                entity.Property(e => e.Fname)
                    .IsRequired()
                    .HasColumnName("fname")
                    .HasMaxLength(50);

                entity.Property(e => e.Lname)
                    .HasColumnName("lname")
                    .HasMaxLength(50);
            });
        }
    }
}
