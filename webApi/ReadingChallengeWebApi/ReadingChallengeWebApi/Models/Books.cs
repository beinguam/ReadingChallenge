using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Books
    {
        public Books()
        {
            UserBooks = new HashSet<UserBooks>();
        }

        public int BookId { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public int? Pages { get; set; }

        public ICollection<UserBooks> UserBooks { get; set; }
    }
}
