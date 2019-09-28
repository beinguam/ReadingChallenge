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
    public class OrgUsersController : ControllerBase
    {
        private readonly ReadingChallengeDBContext _context;

        public OrgUsersController(ReadingChallengeDBContext context)
        {
            _context = context;
        }

        // GET: api/OrgUsers
        [HttpGet]
        public IEnumerable<OrgUsers> GetOrgUsers()
        {
            return _context.OrgUsers;
        }

        // GET: api/OrgUsers/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrgUsers([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orgUsers = await _context.OrgUsers.FindAsync(id);

            if (orgUsers == null)
            {
                return NotFound();
            }

            return Ok(orgUsers);
        }

        // GET: api/OrgUsers/UserId
        [HttpGet("organizations/{id}")]
        public IEnumerable<OrgUsers> GetOrganizations([FromRoute] int id)
        {
            var UserOrgs = _context.OrgUsers.Where(x => x.UserId == id);

            return UserOrgs;
        }

        // PUT: api/OrgUsers/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrgUsers([FromRoute] int id, [FromBody] OrgUsers orgUsers)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != orgUsers.Id)
            {
                return BadRequest();
            }

            _context.Entry(orgUsers).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrgUsersExists(id))
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

        // POST: api/OrgUsers
        [HttpPost]
        public async Task<IActionResult> PostOrgUsers([FromBody] OrgUsers orgUsers)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.OrgUsers.Add(orgUsers);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetOrgUsers", new { id = orgUsers.Id }, orgUsers);
        }

        // DELETE: api/OrgUsers/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrgUsers([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var orgUsers = await _context.OrgUsers.FindAsync(id);
            if (orgUsers == null)
            {
                return NotFound();
            }

            _context.OrgUsers.Remove(orgUsers);
            await _context.SaveChangesAsync();

            return Ok(orgUsers);
        }

        private bool OrgUsersExists(int id)
        {
            return _context.OrgUsers.Any(e => e.Id == id);
        }
    }
}