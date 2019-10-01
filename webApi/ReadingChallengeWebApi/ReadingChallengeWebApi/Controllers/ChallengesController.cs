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
    public class ChallengesController : ControllerBase
    {
        private readonly ReadingChallengeDBContext _context;

        public ChallengesController(ReadingChallengeDBContext context)
        {
            _context = context;
        }

        // GET: api/[controller]/types
        [HttpGet("types")]
        public IEnumerable<ChallengeTypes> GetChallengeTypes()
        {
            return _context.ChallengeTypes;
        }

        // GET: api/Challenges/User/5 --Get challenges by user
        [HttpGet("user/{id}")]
        public ActionResult GetUser([FromRoute] int id)
        {
            var userOrgs = _context.OrgUsers
                .Where(x => x.UserId == id)
                    .Include(x => x.OrgUserChallenges)
                        .ThenInclude(c => c.Challenge)
                .Select(o => new { o.OrgUserChallenges });


            //var userOrgs = _context.OrgUsers
            //    .Where(x => x.UserId == id)
            //    .Include(x => x.OrgUserChallenges)
            //    .ThenInclude(x => x.org
            //.Select(o => new { o.OrgUserChallenges });

            //var userOrgs = _context.OrgUsers
            //    .Where(x => x.UserId == id)
            //    .Include(ou => ou.Org)
            //    .Select(o => new { o.Org.Id, o.OrgId, o.Org.Name });

            return Ok(userOrgs);
        }

        // GET: api/Challenges
        [HttpGet]
        public IEnumerable<Challenges> GetChallenges()
        {
            return _context.Challenges;
        }

        // GET: api/Challenges/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetChallenges([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var challenges = await _context.Challenges.FindAsync(id);

            if (challenges == null)
            {
                return NotFound();
            }

            return Ok(challenges);
        }

        // PUT: api/Challenges/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutChallenges([FromRoute] int id, [FromBody] Challenges challenges)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != challenges.Id)
            {
                return BadRequest();
            }

            _context.Entry(challenges).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ChallengesExists(id))
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

        // POST: api/Challenges
        [HttpPost]
        public async Task<IActionResult> PostChallenges([FromBody] Challenges challenges)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Challenges.Add(challenges);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ChallengesExists(challenges.Id))
                {
                    return new StatusCodeResult(StatusCodes.Status409Conflict);
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetChallenges", new { id = challenges.Id }, challenges);
        }

        // DELETE: api/Challenges/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteChallenges([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var challenges = await _context.Challenges.FindAsync(id);
            if (challenges == null)
            {
                return NotFound();
            }

            _context.Challenges.Remove(challenges);
            await _context.SaveChangesAsync();

            return Ok(challenges);
        }

        private bool ChallengesExists(int id)
        {
            return _context.Challenges.Any(e => e.Id == id);
        }
    }
}