using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Organizations
    {
        public Organizations()
        {
            Challenges = new HashSet<Challenges>();
            OrgUsers = new HashSet<OrgUsers>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int? Category { get; set; }

        public OrganizationCategories CategoryNavigation { get; set; }
        public ICollection<Challenges> Challenges { get; set; }
        public ICollection<OrgUsers> OrgUsers { get; set; }
    }
}
