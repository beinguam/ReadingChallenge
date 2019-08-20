using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class Organization
    {
        public Organization()
        {
            Challenge = new HashSet<Challenge>();
        }

        public int OrgId { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }

        public ICollection<Challenge> Challenge { get; set; }
    }
}
