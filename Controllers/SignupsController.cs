using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AabeDfwApiV2.Data;
using AabeDfwApiV2.Models;

namespace AabeDfwApiV2.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SignupsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public SignupsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/signups
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Signup>>> GetSignups()
        {
            return await _context.Signups.ToListAsync();
        }

        // GET: api/signups/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Signup>> GetSignup(int id)
        {
            var signup = await _context.Signups.FindAsync(id);

            if (signup == null)
            {
                return NotFound();
            }

            return signup;
        }

        // POST: api/signups
        [HttpPost]
        public async Task<ActionResult<Signup>> CreateSignup(Signup signup)
        {
            _context.Signups.Add(signup);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetSignup), new { id = signup.Id }, signup);
        }

        // PUT: api/signups/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateSignup(int id, Signup signup)
        {
            if (id != signup.Id)
            {
                return BadRequest();
            }

            _context.Entry(signup).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/signups/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSignup(int id)
        {
            var signup = await _context.Signups.FindAsync(id);
            if (signup == null)
            {
                return NotFound();
            }

            _context.Signups.Remove(signup);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}