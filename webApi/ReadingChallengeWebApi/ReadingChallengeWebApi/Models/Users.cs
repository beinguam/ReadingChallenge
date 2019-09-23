using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Users
    {
        public Users()
        {
            OrgUsers = new HashSet<OrgUsers>();
            UserBooks = new HashSet<UserBooks>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public ICollection<OrgUsers> OrgUsers { get; set; }
        public ICollection<UserBooks> UserBooks { get; set; }
    }
}
