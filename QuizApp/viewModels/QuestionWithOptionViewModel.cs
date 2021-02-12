using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizApp.viewModels
{
    public class QuestionWithOptionViewModel
    {
        public int CategoryId { get; set; }
        public string QuestionName { get; set; }
        public List<string> Options { get; set; }
        public string AnswerText { get; set; }
    }
}