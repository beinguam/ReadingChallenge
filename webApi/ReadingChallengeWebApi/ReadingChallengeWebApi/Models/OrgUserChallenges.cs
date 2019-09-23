using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class OrgUserChallenges
    {
        public int Id { get; set; }
        public int OrgUserId { get; set; }
        public int ChallengeId { get; set; }

        public Challenges Challenge { get; set; }
        public OrgUsers OrgUser { get; set; }
    }
}
