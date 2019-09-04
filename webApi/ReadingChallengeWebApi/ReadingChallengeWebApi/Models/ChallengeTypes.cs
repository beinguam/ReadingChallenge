using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class ChallengeTypes
    {
        public ChallengeTypes()
        {
            Challenges = new HashSet<Challenges>();
        }

        public int Id { get; set; }
        public string Name { get; set; }

        public ICollection<Challenges> Challenges { get; set; }
    }
}
