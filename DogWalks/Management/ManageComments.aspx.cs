using DogWalks.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DogWalks.Management
{
  public partial class ManageComments : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
      List<int> comments = new List<int>();
      //loop through rows and select selected comments
      for (int i = 0; i < GridView1.Rows.Count; i++ )
      {
        CheckBox cb = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
        if (cb.Checked)
        {
          int commentID = Int32.Parse(GridView1.Rows[i].Cells[2].Text);
          comments.Add(commentID);
        }
      }

      //if at least 1 comment selected
      if (comments.Count > 0)
      {
        using(var db = new WalkContext())
        {
          foreach (int commentID in comments)
          {
            var comment = (from c in db.Comments
                       where c.CommentID == commentID
                       select c).Single();

            db.Comments.Remove(comment);
          }
          db.SaveChanges();
          Response.Redirect("~/Management/ManageComments.aspx");
        }
      }
    }
  }
}