using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DogWalks.Management
{
  public partial class ManageFeatures : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      //user is a moderator and not an administrator 
      if (User.IsInRole("Moderator") && !User.IsInRole("Administrator"))
      {
        Response.Redirect("default.aspx");
      }
    }
  }
}