using QuizApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace QuizApp.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account

        QUIZDBEntities1 context;
        public AccountController()
        {
            context = new QUIZDBEntities1();
        }

        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(Admin admin)
        {
            if (ModelState.IsValid)
            {
                Admin admin1 = context.Admins.SingleOrDefault(model => model.UserName == admin.UserName);
                if (admin1 == null)
                {
                    ModelState.AddModelError(String.Empty, "Email Not Found");
                }
                else if (admin1.UserPassword != admin.UserPassword)
                {
                    ModelState.AddModelError(String.Empty, "Email & Password Not Found");

                }
                else
                {
                    FormsAuthentication.SetAuthCookie(admin1.UserName, false);
                    var authTicket = new FormsAuthenticationTicket(1, admin1.UserName, DateTime.Now, DateTime.Now.AddMinutes(20), false, "Admin");
                    string encyrpDate = FormsAuthentication.Encrypt(authTicket);
                    var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encyrpDate);
                    HttpContext.Response.Cookies.Add(authCookie);
                    return RedirectToAction("Index", "Admin");
                }
            }
            return View();
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
    }
}