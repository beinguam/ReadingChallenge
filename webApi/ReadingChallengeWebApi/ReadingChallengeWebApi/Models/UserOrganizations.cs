using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ReadingChallengeWebApi.Models
{
    public class UserOrganizations
    {
        public int UserId { get; set; }
        public int OrgId { get; set; }
        public string Name { get; set; }
    }
}
