using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using DogWalks.DAL;


namespace DogWalks
{
  public partial class ViewUserProfile : System.Web.UI.Page
  {
    string profileID;
    int userID;

    protected void Page_Load(object sender, EventArgs e)
    {
     
      
      profileID = Request.QueryString["UserProfileID"];    

      if (string.IsNullOrEmpty(profileID))
      {
        lblNotFound.Visible = true;
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
            }
            else
            {
              lblNotFound.Visible = false;
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
            if (lblComments != null)
            { 
                var comments = (from c in db.Comments
                                where c.AuthorID == userID
                                select c).ToList();

                lblComments.Text = comments.Count.ToString();              
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