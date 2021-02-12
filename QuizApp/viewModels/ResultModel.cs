using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizApp.viewModels
{
    public class ResultModel
    {
        public string Question { get; set; }
        public string Answer { get; set; }
        public string AnswerUser { get; set; }
        public string status { get; set; }
    }
}