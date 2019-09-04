using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class UserBooks
    {
        public int Id { get; set; }
        public int BookId { get; set; }
        public int UserId { get; set; }

        public Books Book { get; set; }
        public Users User { get; set; }
    }
}
