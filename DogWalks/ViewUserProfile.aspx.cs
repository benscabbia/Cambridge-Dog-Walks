using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using DogWalks.DAL;
using Microsoft.AspNet.Identity;



namespace DogWalks
{
  public partial class ViewUserProfile : System.Web.UI.Page
  {
    string profileID;
    int userID;

    protected void Page_Load(object sender, EventArgs e)
    {
      profileID = Request.QueryString["UserProfileID"];
      if (!User.Identity.IsAuthenticated)
      {
        lblNotAuthenticated.Visible = true;
        lblNotFound.Visible = false;
        PanelUserProfile.Visible = false;
      }
      else if(string.IsNullOrEmpty(profileID)){

        lblNotFound.Visible = true;
        lblNotAuthenticated.Visible = false;
        PanelUserProfile.Visible = false;
      }
      else
      {
        try
        {
          userID = Int32.Parse(profileID);
          using (WalkContext db = new WalkContext())
          {
            var profile = (from n in db.UserProfiles
                           where n.UserProfileID == userID
                           select n).Single();
            if (profile == null)
            {
              lblNotFound.Visible = true;
              PanelUserProfile.Visible = false;
              lblNotAuthenticated.Visible = false;
            }
            else
            {
              lblNotFound.Visible = false;
              lblNotAuthenticated.Visible = false;
              PanelUserProfile.Visible = true;
            }
          }
        }
        catch (Exception ex)
        {
          lblNotFound.Visible = true;
          PanelUserProfile.Visible = false;
        }
      }
      
    }

    // The id parameter should match the DataKeyNames value set on the control
    // or be decorated with a value provider attribute, e.g. [QueryString]int id
    public DogWalks.DAL.UserProfile UserProfileFormView_GetItem([QueryString("UserProfileID")] int? UserProfileID)
    {
      using(var db = new WalkContext())
      {
        var userProfile = (from u in db.UserProfiles
                           where u.UserProfileID == UserProfileID
                           select u).Single();
        return userProfile;        
      }
    }

    protected void UserProfileFormView_DataBound(object sender, EventArgs e)
    {
      float result = 0; //used by the user reputation and star rating

      if (UserProfileFormView.CurrentMode == FormViewMode.ReadOnly)
      {
        //Check the RowType to where the Control is placed
        if (UserProfileFormView.Row.RowType == DataControlRowType.DataRow)
        {
          //Just Changed the index of cells based on your requirement
          using (var db = new WalkContext())
          {
            //Number of comments posted by user
            Label lblComments = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblNumOfComments");
            int userComments = 0;
            if (lblComments != null)
            {
              userComments = (from c in db.Comments
                                where c.AuthorID == userID
                                select c).Count();

              lblComments.Text = userComments.ToString();
            }

            

            //Proportion of Comments
            Label lblPropComments = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblPropOfComments");
            if (lblPropComments != null)
            {
              var totalComments = (from c in db.Comments
                              select c).Count();

              lblPropComments.Text = userComments.ToString() + " / " + totalComments.ToString();

            }

            //Proportion of Dog Walks Uploaded
            Label lblPropWalks = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblPropOfWalks");
            if (lblPropWalks != null)
            {
              var totalDogWalks = (from c in db.DogWalks
                                   select c).Count();

              var totalUserDogWalks = (from c in db.DogWalks
                                       where c.AuthorID == userID
                                       select c).Count();

              lblPropWalks.Text = totalUserDogWalks.ToString() + " / " + totalDogWalks.ToString(); 

            }

            //Proportion of Ratings given
            Label lblPropRatings = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblPropOfRatings");
            if (lblPropRatings != null)
            {
              var totalRatings = (from r in db.Ratings
                                  select r).Count();

              var userRatings = (from r in db.Ratings
                                 where r.AuthorID == userID
                                 select r).Count();

              lblPropRatings.Text = userRatings.ToString() + " / " + totalRatings.ToString(); 
            }

            //user stats profile visibility
            Panel panelStats = (Panel)UserProfileFormView.Row.Cells[0].FindControl("PanelStats");
            Panel panelBlank = (Panel)UserProfileFormView.Row.Cells[0].FindControl("PanelBlank");
            

             //check logged-in user stats to see if they can view user stats
              var userIdentity = User.Identity.GetUserId();
              if (userIdentity != null && panelStats != null && panelBlank != null)
              {
                var loggedinUserID = (from u in db.UserProfiles
                                      where u.FKUserID == userIdentity
                                      select u).SingleOrDefault();

                if (loggedinUserID != null)
                {
                  //not viewing it's own profile
                    var nOfComments = (from c in db.Comments
                                         where c.AuthorID == loggedinUserID.UserProfileID
                                         select c).Count();
                    var nOfWalks = (from w in db.DogWalks
                                      where w.AuthorID == loggedinUserID.UserProfileID
                                      select w).Count();
                    var nOfRatings = (from r in db.Ratings
                                        where r.AuthorID == loggedinUserID.UserProfileID
                                        select r).Count();

                    //what user must do to unlock the stats panel
                    Label lblActionsLeft = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblActionsLeft");
                    if (lblActionsLeft != null)
                    {
                      if (nOfComments < 1) lblActionsLeft.Text += "<li>at least 1 comment</li>";
                      if (nOfWalks < 1) lblActionsLeft.Text += "<li>at least 1 walk</li>";
                      if (nOfRatings < 1) lblActionsLeft.Text += "<li>at least 1 rating</li>";

                      var missingProperties = profileComplete(db);

                      if (missingProperties != null)
                      {
                        foreach (string property in missingProperties)
                        {
                          lblActionsLeft.Text += "<li>" + property + "</li>";
                        }
                      }
                    }

                  if (loggedinUserID.UserProfileID != userID)
                  {
                    if (nOfComments > 0 && nOfWalks > 0 && nOfRatings > 0 && isProfileComplete(db))
                    {
                      panelStats.Visible = true;
                      panelBlank.Visible = false;
                    }
                    else
                    {
                      panelStats.Visible = false;
                      panelBlank.Visible = true;
                    }
                  }
                }

              }

              //Calculates the Overall average rating for the users uploaded walks             
              System.Web.UI.HtmlControls.HtmlInputGenericControl dogWalkRating = (System.Web.UI.HtmlControls.HtmlInputGenericControl)UserProfileFormView.Row.Cells[0].FindControl("dogWalkRating");
              if (dogWalkRating != null)
              {
                var allUserWalks = (from w in db.DogWalks where w.AuthorID == userID select w.WalkID).ToList();

                int nOfWalks = 0;
                float totalScore = 0;
                foreach (int walkID in allUserWalks)
                {
                  float selectWalkRatingsScore = (float)(from r in db.Ratings where r.WalkID == walkID select r.Score).DefaultIfEmpty().Average();
                  if (selectWalkRatingsScore > 0)
                  {
                    nOfWalks++;
                    totalScore += selectWalkRatingsScore;
                  }
                }

                if (totalScore > 0)
                {
                  result = (totalScore / nOfWalks);

                  dogWalkRating.Value = result.ToString("#.#");
                }
              }

              Label userScore = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblUserScore");
              if (userScore != null)
              {
                var nOfComments = db.Comments.Where(c => c.AuthorID == userID).Count();
                var nOfWalks = db.DogWalks.Where(w => w.AuthorID == userID).Count();
                var nOfRatings = db.Ratings.Where(r => r.AuthorID == userID).Count();

                //calculating user reputation = (5w + 3c + 2r) * 10 * m, w=nOfWalks, c=nOfComments, r=nOfRatings, m=multiplier
                // walk = 5 points, comment = 3 points, rating = 2
                var multiplier = result;
                if (result == 0) multiplier++;

                var reputation = (nOfWalks * 5 + nOfComments * 3 + nOfRatings * 2) * 10 * multiplier;
                var roundedReputation = Math.Round(reputation/10, MidpointRounding.AwayFromZero) * 10;
                userScore.Text = roundedReputation.ToString();
              }

            //Uploaded Walks by user
            Repeater repeaterUploadedWalks = (Repeater)UserProfileFormView.Row.Cells[0].FindControl("RepeaterUploadedWalks");

            if (repeaterUploadedWalks != null)
            {
              var userDogWalks = (from w in db.DogWalks
                                  where w.AuthorID == userID
                                  select w).ToList();

              repeaterUploadedWalks.DataSource = userDogWalks;
              repeaterUploadedWalks.DataBind();                 
            }
            //favourite walks by user
            Repeater repeaterFavouriteWalks = (Repeater)UserProfileFormView.Row.Cells[0].FindControl("RepeaterFavouriteWalks");
            if (repeaterFavouriteWalks != null && userID > 0)
            {
              var userProfile = (from u in db.UserProfiles
                                   where u.UserProfileID == userID
                                   select u).Single();

              if(userProfile != null)
              {
                var userFavouriteWalks = userProfile.DogWalks;
                repeaterFavouriteWalks.DataSource = userFavouriteWalks;
                repeaterFavouriteWalks.DataBind();  
              }

              
            }

          }
        }
      }
    }
    public List<string> profileComplete(WalkContext db)
    {
      var user = User.Identity.GetUserId();
      List<string> missingProperties = new List<string>();
      if (user != null)
      {
        var profile = db.UserProfiles.Where(u => u.FKUserID == user).SingleOrDefault();

        if (profile != null)
        {
          if (string.IsNullOrEmpty(profile.FirstName)) missingProperties.Add("First Name");
          if (string.IsNullOrEmpty(profile.LastName)) missingProperties.Add("Last Name");
          if (string.IsNullOrEmpty(profile.Address)) missingProperties.Add("Address");
          if (string.IsNullOrEmpty(profile.Postcode)) missingProperties.Add("Postcode");
          if (string.IsNullOrEmpty(profile.AboutMe)) missingProperties.Add("About Me");
          if (string.IsNullOrEmpty(profile.ProfilePicture)) missingProperties.Add("Profile Picture");
        }
      }
      return missingProperties;
    }

    public bool isProfileComplete(WalkContext db)
    {
      var missingProperty = profileComplete(db);
      if (missingProperty.Count < 1) return true;
      return false;
    }    
  }
}