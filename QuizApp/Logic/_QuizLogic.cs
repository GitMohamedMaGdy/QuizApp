using QuizApp.Models;
using QuizApp.viewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuizApp.Logic
{
    public class _QuizLogic
    {

        QUIZDBEntities1 context;

        public _QuizLogic()
        {
            context = new QUIZDBEntities1();
        }

        public QuizCategoryViewModel GetQuizCategoryViewModel()
        {
            QuizCategoryViewModel quizVM = new QuizCategoryViewModel();
            quizVM.ListCategory = (from category in context.Categories
                                   select new SelectListItem
                                   {
                                       Text = category.CategoryName,
                                       Value = category.CategoryId.ToString()
                                   }).ToList();
            return quizVM;
        }

        public User AddCandidateToUsers(string candidateName, int categoryId)
        {
            User user = new User();
            user.UserName = candidateName;
            user.LoginTime = DateTime.Now;
            user.CategoryId = categoryId;
            context.Users.Add(user);
            context.SaveChanges();
            HttpContext.Current.Session["CandidateName"] = candidateName;
            HttpContext.Current.Session["CategoryId"] = categoryId;
            HttpContext.Current.Session["UserId"] = user.UserId;
            return user;
        }

        public QuizQuestion getQuestionCandidateAnswers(CandidateAnswer candidateAnswer)
        {
            bool isLast = false;
            if (candidateAnswer.AnswerText != null)
            {
                List<CandidateAnswer> objCandidateAnswers = HttpContext.Current.Session["CandidateQuestionAnswer"] as List<CandidateAnswer>;
                if (objCandidateAnswers == null)
                {
                    objCandidateAnswers = new List<CandidateAnswer>();
                }
                objCandidateAnswers.Add(candidateAnswer);
                HttpContext.Current.Session["CandidateQuestionAnswer"] = objCandidateAnswers;

            }
            int pageSize = 1;
            int pageNumber = 0;
            int CategoryId = Convert.ToInt32(HttpContext.Current.Session["CategoryId"]);
            if (HttpContext.Current.Session["CandidateQuestionAnswer"] == null)
            {
                pageNumber += 1;
            }
            else
            {
                List<CandidateAnswer> candidateAnswers = HttpContext.Current.Session["CandidateQuestionAnswer"] as List<CandidateAnswer>;
                pageNumber = candidateAnswers.Count + 1;
            }
            List<Question> listOfQuestions = new List<Question>();
            listOfQuestions = context.Questions.Where(model => model.CategoryId == CategoryId).ToList();
            if (pageNumber == listOfQuestions.Count)
            {
                isLast = true;
            }
            QuizQuestion objAnswerViewModel = new QuizQuestion();
            Question question = new Question();
            question = listOfQuestions.Skip((pageNumber - 1) * pageSize).Take(pageSize).FirstOrDefault();
            objAnswerViewModel.isLast = isLast;
            objAnswerViewModel.QuestionId = question.QuestionId;
            objAnswerViewModel.QuestionText = question.QuestionText;
            objAnswerViewModel.ListOptions = (from option in context.Options
                                              where option.QuestionId == objAnswerViewModel.QuestionId
                                              select new QuizOption()
                                              {
                                                  OptionName = option.optionName,
                                                  Id = option.OptionId
                                              }).ToList();
            
            return objAnswerViewModel;
        }

        public bool saveCandidateAnswer(CandidateAnswer candidateAnswer)
        {
            List<CandidateAnswer> canAnswers = HttpContext.Current.Session["CandidateQuestionAnswer"] as List<CandidateAnswer>;
            if (candidateAnswer.AnswerText != null)
            {
                List<CandidateAnswer> objCandidateAnswers = HttpContext.Current.Session["CandidateQuestionAnswer"] as List<CandidateAnswer>;
                if (objCandidateAnswers == null)
                {
                    objCandidateAnswers = new List<CandidateAnswer>();
                }
                objCandidateAnswers.Add(candidateAnswer);
                HttpContext.Current.Session["CandidateQuestionAnswer"] = objCandidateAnswers;

            }
            foreach (var item in canAnswers)
            {
                Result result = new Result();
                result.AnswerText = item.AnswerText;
                result.QuestionId = item.QuestionId;
                result.UserId = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
                context.Results.Add(result);
            }
            if (context.SaveChanges() > 0)
            {
                return true;
            }
            return false;
        }

        public List<ResultModel> GetFinalResults()
        {
            List<CandidateAnswer> listOfQuestionAnswers;
            listOfQuestionAnswers = HttpContext.Current.Session["CandidateQuestionAnswer"] as List<CandidateAnswer>;
            var userResults = (from objResult in listOfQuestionAnswers
                               join objAnswer in context.Answers on objResult.QuestionId equals objAnswer.QuestionId
                               join objQuestion in context.Questions on objResult.QuestionId equals objQuestion.QuestionId
                               select new ResultModel()
                               {

                                   Question = objQuestion.QuestionText,
                                   Answer = objAnswer.AnswerText,
                                   AnswerUser = objResult.AnswerText,
                                   status = objAnswer.AnswerText == objResult.AnswerText ? "correct" : "wrong"


                               }).ToList();

            HttpContext.Current.Session.Abandon();
            return userResults;
        }
    }
}