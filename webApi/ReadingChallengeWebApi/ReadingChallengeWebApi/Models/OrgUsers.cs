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
        public int ChallengeId { get; set; }

        public Challenges Challenge { get; set; }
        public Organizations Org { get; set; }
        public ICollection<OrgUserChallenges> OrgUserChallenges { get; set; }
    }
}
