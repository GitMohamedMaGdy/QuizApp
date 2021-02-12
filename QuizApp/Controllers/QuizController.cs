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
    public class QuizController : Controller
    {
        QUIZDBEntities1 context;
        _QuizLogic quizLogic;

        public QuizController()
        {
            context = new QUIZDBEntities1();
            quizLogic = new _QuizLogic();
        }
        // GET: Quiz
        public ActionResult Index()
        {
            return View(quizLogic.GetQuizCategoryViewModel());
        }

        [HttpPost]
        public ActionResult Index(string candidateName, int categoryId)
        {
            User user = quizLogic.AddCandidateToUsers(candidateName, categoryId);
            if (user != null)
            {
                return View("QuestionIndex");
            }
            return View();
        }

        [HttpGet]
        public PartialViewResult UserQuestionAnswer(CandidateAnswer candidateAnswer)
        {
            QuizQuestion quizQuestion = quizLogic.getQuestionCandidateAnswers(candidateAnswer);
            return PartialView ("_QuizQuestion", quizQuestion);
        }

        public JsonResult saveCandidateAnswer(CandidateAnswer candidateAnswer)
        {
            if (quizLogic.saveCandidateAnswer(candidateAnswer))
            {
                return Json(new { message = "Data is saved successfully", success = true }, JsonRequestBehavior.AllowGet);

            }
            else
            {
                return Json(new { message = "Error in saving result", success = true }, JsonRequestBehavior.AllowGet);

            }
        }

        public ActionResult GetFinalResult()
        {
            return View (quizLogic.GetFinalResults());
        }


    }
}