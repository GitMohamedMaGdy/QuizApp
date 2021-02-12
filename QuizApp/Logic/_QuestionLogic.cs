using QuizApp.Models;
using QuizApp.viewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuizApp.Logic
{
    public class _QuestionLogic
    {

        QUIZDBEntities1 context;

        public _QuestionLogic()
        {
            context = new QUIZDBEntities1();
        }

        public QuestionViewModel getQuestionViewModel()
        {
            QuestionViewModel questionVM = new QuestionViewModel();
            questionVM.CategoryList = (from category in context.Categories
                                 select new SelectListItem
                                 {
                                     Text = category.CategoryName,
                                     Value = category.CategoryId.ToString()
                                 }).ToList();
            return questionVM;
        }
        public bool AddQuestion(QuestionWithOptionViewModel questionVM)
        {
            Question question = new Question();
            question.QuestionText = questionVM.QuestionName;
            question.CategoryId = questionVM.CategoryId;
            question.isActive = true;
            question.isMultiple = false;
            context.Questions.Add(question);
            context.SaveChanges();
            int questionId = question.QuestionId;

            foreach (var item in questionVM.Options)
            {
                Option option = new Option();
                option.optionName = item;
                option.QuestionId = questionId;
                option.Question = question;
                context.Options.Add(option);
            }

            Answer answer = new Answer();
            answer.AnswerText = questionVM.AnswerText;
            answer.QuestionId = questionId;
            answer.Question = question;
            context.Answers.Add(answer);
            if (context.SaveChanges() > 0)
            {
                return true;
            }
            return false;
        }
    }
}