using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class OrgUsers
    {
        public int Id { get; set; }
        public int OrgId { get; set; }
        public int UserId { get; set; }

        public Organizations Org { get; set; }
        public Users User { get; set; }
    }
}
