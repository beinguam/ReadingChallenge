using System;
using System.Collections.Generic;

namespace ReadingChallengeWebApi.Models
{
    public partial class OrganizationCategories
    {
        public OrganizationCategories()
        {
            Organizations = new HashSet<Organizations>();
        }

        public int OrganizationCategoryId { get; set; }
        public string Name { get; set; }

        public ICollection<Organizations> Organizations { get; set; }
    }
}
