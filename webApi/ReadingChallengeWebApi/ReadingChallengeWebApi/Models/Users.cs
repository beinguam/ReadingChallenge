using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Users
    {
        public Users()
        {
            OrgUserChallenges = new HashSet<OrgUserChallenges>();
            UserBooks = new HashSet<UserBooks>();
        }

        public int UserId { get; set; }
        public string Fname { get; set; }
        public decimal? Lname { get; set; }

        public ICollection<OrgUserChallenges> OrgUserChallenges { get; set; }
        public ICollection<UserBooks> UserBooks { get; set; }
    }
}
