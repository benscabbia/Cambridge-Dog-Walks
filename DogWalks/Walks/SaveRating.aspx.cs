using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Web.ModelBinding;
using System.Collections;
using Microsoft.AspNet.Identity;

namespace DogWalks.Walks
{
  public partial class SaveRating : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      //Walks/SaveRating?Score=2&WalkID=18

          using (var db = new WalkContext())
          {
            var newRating = new Rating();

            var userID = User.Identity.GetUserId();
            var userProfileID = (from u in db.UserProfiles
                             where u.FKUserID == userID
                             select u).Single().UserProfileID;

            newRating.AuthorID = userProfileID;

            newRating.Score = Convert.ToDouble(Request.Params["Score"]);
            newRating.WalkID = Convert.ToInt32(Request.Params["WalkID"]);

            if(newRating.Score==0 || newRating.AuthorID==0 || newRating.WalkID==0) return;

            //existing ratings for current walk
            var userRating = (from r in db.Ratings
                           where r.WalkID == newRating.WalkID && r.AuthorID == newRating.AuthorID                           
                           select r).SingleOrDefault();
            if (userRating != null) db.Ratings.Remove(userRating);

            db.Ratings.Add(newRating);
            db.SaveChanges();
            
          }
        }
  }
}