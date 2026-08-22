using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using AabeDfwApiV2.Data;
using AabeDfwApiV2.Models;

namespace AabeDfwApiV2.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EventsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public EventsController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/Events
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Event>>> GetEvents()
        {
            return await _context.Events.ToListAsync();
        }

        // GET: api/Events/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Event>> GetEvent(int id)
        {
            var Event = await _context.Events.FindAsync(id);

            if (Event == null)
            {
                return NotFound();
            }

            return Event;
        }

        // POST: api/Events
        [HttpPost]
        public async Task<ActionResult<Event>> CreateEvent(Event Event)
        {
            _context.Events.Add(Event);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetEvent), new { id = Event.Id }, Event);
        }

        // PUT: api/Events/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEvent(int id, Event Event)
        {
            if (id != Event.Id)
            {
                return BadRequest();
            }

            _context.Entry(Event).State = EntityState.Modified;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEvent(int id)
        {
            var Event = await _context.Events.FindAsync(id);
            if (Event == null)
            {
                return NotFound();
            }

            _context.Events.Remove(Event);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}