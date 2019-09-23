using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class OrgUsers
    {
        public OrgUsers()
        {
            OrgUserChallenges = new HashSet<OrgUserChallenges>();
        }

        public int Id { get; set; }
        public int OrgId { get; set; }
        public int UserId { get; set; }

        public Organizations Org { get; set; }
        public Users User { get; set; }
        public ICollection<OrgUserChallenges> OrgUserChallenges { get; set; }
    }
}
