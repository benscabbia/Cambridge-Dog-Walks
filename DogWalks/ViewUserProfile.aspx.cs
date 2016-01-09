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

                    Label userScore = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblUserScore");
                    if (userScore != null)
                    {
                      //calculating user score
                      // walk = 5 points, comment = 3 points, rating = 2
                      userScore.Text = ((nOfWalks * 5 + nOfComments * 3 + nOfRatings * 2) * 10).ToString();
                    }


                  if (loggedinUserID.UserProfileID != userID)
                  {
                    if (nOfComments > 0 && nOfWalks > 0 && nOfRatings > 0)
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

            //Average Rating
            System.Web.UI.HtmlControls.HtmlInputGenericControl starRating = (System.Web.UI.HtmlControls.HtmlInputGenericControl)UserProfileFormView.Row.Cells[0].FindControl("starRating");
            if (starRating != null)
            {
              var userRatings = (from r in db.Ratings
                                 where r.AuthorID == userID
                                 select r);

              int numberRatings = userRatings.Count();

              if (numberRatings > 0)
              {
                var average = userRatings.Average(u => u.Score);
                starRating.Value = average > 0 ? average.ToString("#.##") : "";
              }
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
  }
}