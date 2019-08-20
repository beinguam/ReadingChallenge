using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Challenge
    {
        public int ChallengeId { get; set; }
        public string Name { get; set; }
        public string BeginDate { get; set; }
        public string EndDate { get; set; }
        public string Type { get; set; }
        public string NumGoal { get; set; }
        public int? OrgId { get; set; }

        public Organization Org { get; set; }
    }
}
