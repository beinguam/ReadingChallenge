using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ReadingChallengeWebApi.Models;

namespace ReadingChallengeWebApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class OrgUserChallengesController : ControllerBase
    {
        private readonly ReadingChallengeDBContext _context;

        public OrgUserChallengesController(ReadingChallengeDBContext context)
        {
            _context = context;
        }

        // GET: api/OrgUserChallenges
        [HttpGet]
        public IEnumerable<OrgUserChallenges> GetOrgUserChallenges()
        {
            return _context.OrgUserChallenges;
        }

        // GET: api/OrgUserChallenges/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrgUserChallenges([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orgUserChallenges = await _context.OrgUserChallenges.FindAsync(id);

            if (orgUserChallenges == null)
            {
                return NotFound();
            }

            return Ok(orgUserChallenges);
        }

        // PUT: api/OrgUserChallenges/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrgUserChallenges([FromRoute] int id, [FromBody] OrgUserChallenges orgUserChallenges)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != orgUserChallenges.Id)
            {
                return BadRequest();
            }

            _context.Entry(orgUserChallenges).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrgUserChallengesExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/OrgUserChallenges
        [HttpPost]
        public async Task<IActionResult> PostOrgUserChallenges([FromBody] OrgUserChallenges orgUserChallenges)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.OrgUserChallenges.Add(orgUserChallenges);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrgUserChallenges", new { id = orgUserChallenges.Id }, orgUserChallenges);
        }

        // DELETE: api/OrgUserChallenges/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrgUserChallenges([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orgUserChallenges = await _context.OrgUserChallenges.FindAsync(id);
            if (orgUserChallenges == null)
            {
                return NotFound();
            }

            _context.OrgUserChallenges.Remove(orgUserChallenges);
            await _context.SaveChangesAsync();

            return Ok(orgUserChallenges);
        }

        private bool OrgUserChallengesExists(int id)
        {
            return _context.OrgUserChallenges.Any(e => e.Id == id);
        }
    }
}