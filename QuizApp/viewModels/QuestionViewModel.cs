using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuizApp.viewModels
{
    public class QuestionViewModel
    {
        [Display(Name="Category")]
        [Required(ErrorMessage ="Category is required")]
        public int CategoryId { get; set; }
        public int CategoryName { get; set; }
        [Display(Name = "Question")]
     
        public string QuestionName { get; set; }
        [Display(Name = "Option")]
        public string OptionName { get; set; }
        public IEnumerable<SelectListItem> CategoryList { get; set; }
    }
}