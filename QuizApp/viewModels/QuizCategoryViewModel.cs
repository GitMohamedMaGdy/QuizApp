using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace QuizApp.viewModels
{
    public class QuizCategoryViewModel
    {
        [Display(Name="Category")]
        [Required(ErrorMessage="Category is Required")]
        public int CategoryId { get; set; }
        [Display(Name = "Candidate Name")]
        [Required(ErrorMessage = "Candidate name is Required")]
        public string CandidateName { get; set; }

        public IEnumerable<SelectListItem> ListCategory{ get;set; }

    }
}