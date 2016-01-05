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
          int userID = Int32.Parse(profileID);
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

        if (UserProfileFormView.CurrentMode == FormViewMode.ReadOnly)
        {


        }


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
          Label lbl = (Label)UserProfileFormView.Row.Cells[0].FindControl("lblNumOfComments");
          if (lbl != null)          
          {
            using (var db = new WalkContext())
            {
              int userID;
              if (int.TryParse(profileID, out userID))
              {
              var comments = (from c in db.Comments
                              where c.AuthorID == userID
                              select c).ToList();

              lbl.Text = comments.Count.ToString();
              }              
            }
          }


        }
      }
    }
  }
}