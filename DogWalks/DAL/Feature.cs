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
    
    public partial class Feature
    {
        public Feature()
        {
            this.DogWalks = new HashSet<DogWalk>();
        }
    
        public int FeatureID { get; set; }
        public string Description { get; set; }
        public string FeatureName { get; set; }
        public string PictureUrl { get; set; }
    
        public virtual ICollection<DogWalk> DogWalks { get; set; }
    }
}