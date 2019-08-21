using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Authors
    {
        public Authors()
        {
            Books = new HashSet<Books>();
        }

        public int AuthorId { get; set; }
        public string Name { get; set; }

        public ICollection<Books> Books { get; set; }
    }
}
