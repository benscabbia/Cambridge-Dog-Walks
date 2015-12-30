using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Web.ModelBinding;
using System.Collections;

namespace DogWalks.Walks
{
  public partial class WalkDetail : System.Web.UI.Page
  {    

    //handle empty or false querystring
    protected void Page_Load(object sender, EventArgs e)
    {      
      var walk = Request.QueryString["WalkID"];

      if (string.IsNullOrEmpty(walk))
      {
        Response.Redirect("../Walks/ListWalks.aspx");
      }
      else
      {
        try
        {
          int walkID = Int32.Parse(walk);
          using (WalkContext db = new WalkContext())
          {
            var dogWalk = (from n in db.DogWalks
                        where n.WalkID == walkID
                        select n).SingleOrDefault();
            if (dogWalk == null)
            {
              Response.Redirect("../Walks/ListWalks.aspx");
            }
          }
         }      
        catch(Exception ex)
        {
          Response.Redirect("../Walks/ListWalks.aspx");
        }
      }
    }

    // The id parameter should match the DataKeyNames value set on the control
    // or be decorated with a value provider attribute, e.g. [QueryString]int id
    //method used to populate the form view control
    public DogWalks.DAL.DogWalk FormView1_GetItem([QueryString("WalkID")] int? WalkID)
    {
      using (WalkContext db = new WalkContext())
      {
       //find dog walk with matching ID
       var walk = (from n in db.DogWalks.Include("Features").Include("Pictures").Include("Length")
                   where n.WalkID == WalkID
                   select n).SingleOrDefault();

        //foreach(var f in walk.Features){
            //lbFeatures.Text += f.FeatureName + "<br/>";
        //}
       return walk;
      }          
    }

    //delete a walk
    protected void btnDelete_Click(object sender, EventArgs e)
    {
      int id = Convert.ToInt32(Request.QueryString["WalkID"]);
      System.Diagnostics.Debug.WriteLine("The id of button is: " + id);

      deletePictures(id); //remove pictures first

      using (var db = new WalkContext())
      {
        var walk = (from w in db.DogWalks
                    where w.WalkID == id
                    select w).Single();
               
        //remove features
        foreach (var feature in walk.Features.ToList())
        {
          //db.Features.Re

          walk.Features.Remove(feature);
        }        

        //remove comments
        foreach (var comment in walk.Comments.ToList())
        {
          db.Comments.Remove(comment);
          walk.Comments.Remove(comment);
        }

        //remove ratings
        foreach (var rating in walk.Ratings.ToList())
        {
          db.Ratings.Remove(rating);
          walk.Ratings.Remove(rating);
        }

        db.DogWalks.Remove(walk);
        db.SaveChanges();

        Response.Redirect("~/Walks/ListWalks.aspx");
      }
    }

    //this method removes all the pictures from the walk
    private void deletePictures(int walkId)
    {
      using (var db = new WalkContext())
      {
          var walk = (from w in db.DogWalks
                      where w.WalkID == walkId
                      select w).Single();

          var walkPictures = walk.Pictures;
        //deletes physical picture stored on server and database relative path
        foreach (var picture in walkPictures.ToList())
        {        
          string filename = Server.MapPath(picture.PictureUrl);
          System.IO.File.Delete(filename);

          db.Pictures.Remove(picture);
          walk.Pictures.Remove(picture); //remove picture reference on server
        }
          db.SaveChanges();
      }

    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IQueryable ListView1_GetData()
    {
      using (var db = new WalkContext())
      {
        int id = Convert.ToInt32(Request.QueryString["WalkID"]);

        var walkComments = (from c in db.Comments
                            where c.WalkID == id
                            select c).ToList();
              
        if (walkComments.Count == 0)
        {
          LoginView1.FindControl("lbNoComments").Visible = true;
        }

          return walkComments.AsQueryable();
      }
    }

    public void ListView1_InsertItem([QueryString("WalkID")] int walkID)
    {
      var comment = new DogWalks.DAL.Comment();
      TryUpdateModel(comment);
      if (ModelState.IsValid)
      {
        // Save changes here
        using(var db=new WalkContext())
        {
          comment.WalkID = walkID;
          comment.CreateDateTime = DateTime.Now;
          //comment.AuthorID = User.Identity.Name;
          db.Comments.Add(comment);
          db.SaveChanges();
        }
        Response.Redirect("WalkDetails?WalkID=" + walkID);
       
      }
    }
  }
}