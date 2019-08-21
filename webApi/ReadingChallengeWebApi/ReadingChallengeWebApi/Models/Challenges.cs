using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Challenges
    {
        public Challenges()
        {
            OrgUsers = new HashSet<OrgUsers>();
        }

        public int ChallengeId { get; set; }
        public string Name { get; set; }
        public DateTime BeginDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Type { get; set; }
        public int NumGoal { get; set; }
        public int OrgId { get; set; }

        public Organizations Org { get; set; }
        public ChallengeTypes TypeNavigation { get; set; }
        public ICollection<OrgUsers> OrgUsers { get; set; }
    }
}
