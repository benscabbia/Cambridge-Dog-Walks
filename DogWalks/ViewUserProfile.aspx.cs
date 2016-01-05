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
    protected void Page_Load(object sender, EventArgs e)
    {
      var profileID = Request.QueryString["UserProfileID"];

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


        return userProfile;        
      }
    }
  }
}