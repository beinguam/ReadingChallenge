using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class OrgUserChallenges
    {
        public int Id { get; set; }
        public int OrgUserId { get; set; }
        public int UserId { get; set; }

        public OrgUsers OrgUser { get; set; }
        public Users User { get; set; }
    }
}
