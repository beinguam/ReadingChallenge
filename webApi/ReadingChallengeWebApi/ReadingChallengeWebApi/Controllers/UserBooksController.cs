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
    public class UserBooksController : ControllerBase
    {
        private readonly ReadingChallengeDBContext _context;

        public UserBooksController(ReadingChallengeDBContext context)
        {
            _context = context;
        }

        // GET: api/UserBooks
        [HttpGet]
        public IEnumerable<UserBooks> GetUserBooks()
        {
            return _context.UserBooks;
        }

        // GET: api/UserBooks/5
        [HttpGet("{id}")]
        public async Task<IActionResult> GetUserBooks([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userBooks = await _context.UserBooks.FindAsync(id);

            if (userBooks == null)
            {
                return NotFound();
            }

            return Ok(userBooks);
        }

        // PUT: api/UserBooks/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUserBooks([FromRoute] int id, [FromBody] UserBooks userBooks)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != userBooks.Id)
            {
                return BadRequest();
            }

            _context.Entry(userBooks).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserBooksExists(id))
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

        // POST: api/UserBooks
        [HttpPost]
        public async Task<IActionResult> PostUserBooks([FromBody] UserBooks userBooks)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.UserBooks.Add(userBooks);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUserBooks", new { id = userBooks.Id }, userBooks);
        }

        // DELETE: api/UserBooks/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUserBooks([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var userBooks = await _context.UserBooks.FindAsync(id);
            if (userBooks == null)
            {
                return NotFound();
            }

            _context.UserBooks.Remove(userBooks);
            await _context.SaveChangesAsync();

            return Ok(userBooks);
        }

        private bool UserBooksExists(int id)
        {
            return _context.UserBooks.Any(e => e.Id == id);
        }
    }
}