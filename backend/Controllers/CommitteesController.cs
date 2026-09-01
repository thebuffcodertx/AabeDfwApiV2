using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AabeDfwApiV2.Data;
using AabeDfwApiV2.Models;

namespace AabeDfwApiV2.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CommitteesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CommitteesController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/committees
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Committee>>> GetCommittees()
        {
            return await _context.Committees.ToListAsync();
        }

        // GET: api/committees/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Committee>> GetCommittee(int id)
        {
            var committee = await _context.Committees.FindAsync(id);

            if (committee == null)
            {
                return NotFound();
            }

            return committee;
        }

        // POST: api/committees
        [HttpPost]
        public async Task<ActionResult<Committee>> CreateCommittee(Committee committee)
        {
            _context.Committees.Add(committee);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCommittee), new { id = committee.Id }, committee);
        }

        // PUT: api/committees/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCommittee(int id, Committee committee)
        {
            if (id != committee.Id)
            {
                return BadRequest();
            }

            _context.Entry(committee).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/committees/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCommittee(int id)
        {
            var committee = await _context.Committees.FindAsync(id);
            if (committee == null)
            {
                return NotFound();
            }

            _context.Committees.Remove(committee);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}