﻿using System;
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
    public class OrganizationsController : ControllerBase
    {
        private readonly ReadingChallengeDBContext _context;

        public OrganizationsController(ReadingChallengeDBContext context)
        {
            _context = context;
        }

        // GET: api/[controller]/categories
        [HttpGet("categories")]
        public IEnumerable<OrganizationCategories> GetOrganizationCategories()
        {
            return _context.OrganizationCategories;
        }

        // GET: api/Organizations/User/5 --Get organizations by user
        [HttpGet("user/{id}")]
        public ActionResult GetUser([FromRoute] int id)
        {            
            var userOrgs = _context.OrgUsers
                .Where(x => x.UserId == id)
                .Include(ou => ou.Org)
                .Select(o => new { o.Org.Id , o.OrgId, o.Org.Name });                

            return Ok(userOrgs);
        }

        // GET: api/Challenges/5 --Get organization by challenge
        [HttpGet("challenges/{id}")]
        public ActionResult GetOrganization([FromRoute] int id)
        {
            var OrgsByChallenge = from o in _context.Organizations
                                  join c in _context.Challenges on o.Id equals c.OrgId
                                  where c.Id == id
                                  select o;

            return Ok(OrgsByChallenge);
        }

        // GET: api/Organizations
        [HttpGet]
        public IEnumerable<Organizations> GetOrganizations()
        {
            return _context.Organizations;
        }

        // GET: api/Organizations/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetOrganizations([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var organizations = await _context.Organizations.FindAsync(id);

            if (organizations == null)
            {
                return NotFound();
            }

            return Ok(organizations);
        }

        // PUT: api/Organizations/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutOrganizations([FromRoute] int id, [FromBody] Organizations organizations)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != organizations.Id)
            {
                return BadRequest();
            }

            _context.Entry(organizations).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!OrganizationsExists(id))
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

        // POST: api/Organizations
        [HttpPost]
        public async Task<IActionResult> PostOrganizations([FromBody] Organizations organizations)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Organizations.Add(organizations);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (OrganizationsExists(organizations.Id))
                {
                    return new StatusCodeResult(StatusCodes.Status409Conflict);
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetOrganizations", new { id = organizations.Id }, organizations);
        }

        // DELETE: api/Organizations/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrganizations([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var organizations = await _context.Organizations.FindAsync(id);
            if (organizations == null)
            {
                return NotFound();
            }

            _context.Organizations.Remove(organizations);
            await _context.SaveChangesAsync();

            return Ok(organizations);
        }

        private bool OrganizationsExists(int id)
        {
            return _context.Organizations.Any(e => e.Id == id);
        }
    }
}