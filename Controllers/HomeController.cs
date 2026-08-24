using Microsoft.AspNetCore.Mvc;

namespace AabeDfwApiV2.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}