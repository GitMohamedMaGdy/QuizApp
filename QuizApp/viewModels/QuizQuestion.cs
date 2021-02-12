using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuizApp.viewModels
{
    public class QuizQuestion
    {
        public bool isLast { get; set; }
        public int OptionId { get; set; }
        public int QuestionId { get; set; }
        public string QuestionText { get; set; }
        public List<QuizOption>ListOptions { get; set; }
    }

    public class QuizOption
    {
        public int Id { get; set; }
        public string OptionName { get; set; }
    }
}