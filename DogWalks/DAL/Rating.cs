//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DogWalks.DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Rating
    {
        public int RatingID { get; set; }
        public int WalkID { get; set; }
        public double Score { get; set; }
        public int AuthorID { get; set; }
    
        public virtual DogWalk DogWalk { get; set; }
        public virtual UserProfile UserProfile { get; set; }
    }
}
