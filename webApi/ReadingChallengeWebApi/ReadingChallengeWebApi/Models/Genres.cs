using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Genres
    {
        public Genres()
        {
            Books = new HashSet<Books>();
        }

        public int GenreId { get; set; }
        public string Name { get; set; }

        public ICollection<Books> Books { get; set; }
    }
}
