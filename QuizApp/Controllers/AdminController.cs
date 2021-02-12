using QuizApp.Logic;
using QuizApp.Models;
using QuizApp.viewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuizApp.Controllers
{
    public class AdminController : Controller
    {
        QUIZDBEntities1 context;
        _QuestionLogic _Question;

        public AdminController()
        {
            context = new QUIZDBEntities1();
            _Question = new _QuestionLogic();
        }
        // GET: Admin
        [Authorize]
        public ActionResult Index()
        {
            return View(_Question.getQuestionViewModel());
        }
        [HttpPost]
        public JsonResult Index(QuestionWithOptionViewModel questionVM)
        {

            if (_Question.AddQuestion(questionVM))
            {
                return Json(new { message = "Data is added successfully", success = true }, JsonRequestBehavior.AllowGet);

            }
            return Json(new { message = "Error in adding question", success = false }, JsonRequestBehavior.AllowGet);


        }
    }
}