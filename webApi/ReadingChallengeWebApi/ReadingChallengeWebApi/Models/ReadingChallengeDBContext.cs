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
        public virtual DbSet<Challenges> Challenges { get; set; }
        public virtual DbSet<ChallengeTypes> ChallengeTypes { get; set; }
        public virtual DbSet<Genres> Genres { get; set; }
        public virtual DbSet<OrganizationCategories> OrganizationCategories { get; set; }
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

                entity.Property(e => e.AuthorId).HasColumnName("AuthorID");

                entity.Property(e => e.Name).HasMaxLength(50);
            });

            modelBuilder.Entity<Books>(entity =>
            {
                entity.HasKey(e => e.BookId);

                entity.Property(e => e.BookId).HasColumnName("BookID");

                entity.Property(e => e.Title).IsRequired();

                entity.HasOne(d => d.AuthorNavigation)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.Author)
                    .HasConstraintName("FK__Books__Author__4AB81AF0");

                entity.HasOne(d => d.GenreNavigation)
                    .WithMany(p => p.Books)
                    .HasForeignKey(d => d.Genre)
                    .HasConstraintName("FK__Books__Genre__4BAC3F29");
            });

            modelBuilder.Entity<Challenges>(entity =>
            {
                entity.HasKey(e => e.ChallengeId);

                entity.Property(e => e.ChallengeId).HasColumnName("ChallengeID");

                entity.Property(e => e.BeginDate).HasColumnType("date");

                entity.Property(e => e.EndDate).HasColumnType("date");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.OrgId).HasColumnName("OrgID");

                entity.HasOne(d => d.Org)
                    .WithMany(p => p.Challenges)
                    .HasForeignKey(d => d.OrgId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Challenge__OrgID__4D94879B");

                entity.HasOne(d => d.TypeNavigation)
                    .WithMany(p => p.Challenges)
                    .HasForeignKey(d => d.Type)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Challenges__Type__4CA06362");
            });

            modelBuilder.Entity<ChallengeTypes>(entity =>
            {
                entity.HasKey(e => e.ChallengeTypeId);

                entity.Property(e => e.ChallengeTypeId).HasColumnName("ChallengeTypeID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Genres>(entity =>
            {
                entity.HasKey(e => e.GenreId);

                entity.Property(e => e.GenreId).HasColumnName("GenreID");

                entity.Property(e => e.Name).IsRequired();
            });

            modelBuilder.Entity<OrganizationCategories>(entity =>
            {
                entity.HasKey(e => e.OrganizationCategoryId);

                entity.Property(e => e.OrganizationCategoryId).HasColumnName("OrganizationCategoryID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Organizations>(entity =>
            {
                entity.HasKey(e => e.OrgId);

                entity.Property(e => e.OrgId).HasColumnName("OrgID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.CategoryNavigation)
                    .WithMany(p => p.Organizations)
                    .HasForeignKey(d => d.Category)
                    .HasConstraintName("FK__Organizat__Categ__4E88ABD4");
            });

            modelBuilder.Entity<OrgUserChallenges>(entity =>
            {
                entity.HasKey(e => e.OrgUserChallengeId);

                entity.Property(e => e.OrgUserChallengeId).HasColumnName("OrgUserChallengeID");

                entity.Property(e => e.OrgUserId).HasColumnName("OrgUserID");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.OrgUser)
                    .WithMany(p => p.OrgUserChallenges)
                    .HasForeignKey(d => d.OrgUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrgUserCh__OrgUs__4F7CD00D");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.OrgUserChallenges)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrgUserCh__UserI__5070F446");
            });

            modelBuilder.Entity<OrgUsers>(entity =>
            {
                entity.HasKey(e => e.OrgUserId);

                entity.Property(e => e.OrgUserId).HasColumnName("OrgUserID");

                entity.Property(e => e.ChallengeId).HasColumnName("ChallengeID");

                entity.Property(e => e.OrgId).HasColumnName("OrgID");

                entity.HasOne(d => d.Challenge)
                    .WithMany(p => p.OrgUsers)
                    .HasForeignKey(d => d.ChallengeId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrgUsers__Challe__52593CB8");

                entity.HasOne(d => d.Org)
                    .WithMany(p => p.OrgUsers)
                    .HasForeignKey(d => d.OrgId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrgUsers__OrgID__5165187F");
            });

            modelBuilder.Entity<UserBooks>(entity =>
            {
                entity.HasKey(e => e.UserBookId);

                entity.Property(e => e.UserBookId).HasColumnName("UserBookID");

                entity.Property(e => e.BookId).HasColumnName("BookID");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.Book)
                    .WithMany(p => p.UserBooks)
                    .HasForeignKey(d => d.BookId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__UserBooks__BookI__534D60F1");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserBooks)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__UserBooks__UserI__5441852A");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasKey(e => e.UserId);

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.LastName).HasMaxLength(50);
            });
        }
    }
}
