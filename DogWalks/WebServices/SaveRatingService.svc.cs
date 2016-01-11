using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using DogWalks.DAL;
using System.Web.ModelBinding;
using System.Collections;
using Microsoft.AspNet.Identity;
using System.Web;

namespace DogWalks.WebServices
{
  [ServiceContract(Namespace = "")]
  [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
  public class SaveRatingService
  {
    // To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
    // To create an operation that returns XML,
    //     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
    //     and include the following line in the operation body:
    //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
    [OperationContract]
    public void Save(string score, string walkID, string loggedInUser)
    {
      // Add your operation implementation here
      using (var db = new WalkContext())
      {
        var newRating = new Rating();
        //string userName = OperationContext.Current.ServiceSecurityContext.PrimaryIdentity.GetUserId();
        //var userName2 = ServiceSecurityContext.Current.PrimaryIdentity.GetUserId();
        var userName2 = HttpContext.Current.User.Identity.GetUserId();
        var userName = loggedInUser; 

        var userProfileID = (from u in db.UserProfiles
                             where u.FKUserID == userName
                             select u).Single().UserProfileID;

        newRating.AuthorID = userProfileID;
        newRating.Score = Convert.ToDouble(score);
        newRating.WalkID = Convert.ToInt32(walkID);

        if (newRating.Score == 0 || newRating.AuthorID == 0 || newRating.WalkID == 0) return;

        //existing ratings for current walk
        var userRating = (from r in db.Ratings
                          where r.WalkID == newRating.WalkID && r.AuthorID == newRating.AuthorID
                          select r).SingleOrDefault();
        if (userRating != null) db.Ratings.Remove(userRating);

        db.Ratings.Add(newRating);
        db.SaveChanges();
        return;
      }
    }
  }
}

