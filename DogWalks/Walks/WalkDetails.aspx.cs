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
using System.Web.UI.HtmlControls;

namespace DogWalks.Walks
{
  public partial class WalkDetail : System.Web.UI.Page
  {
    protected string inputValue { get; set; }
    bool userLoggedIn = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;

    protected void Page_Load(object sender, EventArgs e)
    {
      var walk = Request.QueryString["WalkID"];

      //handle empty querystring
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

            
            //dogwalk not found on server
            if (dogWalk == null)
            {
              Response.Redirect("../Walks/ListWalks.aspx");
            }
            else
            {

              //if user is logged in
              if(userLoggedIn)
              {
                var userID = User.Identity.GetUserId();

                var user = (from u in db.UserProfiles
                            where u.FKUserID == userID
                            select u).Single();

                //populate star rating
                var averageRatings = (from r in db.Ratings
                                      where r.WalkID == walkID
                                      select r.Score).DefaultIfEmpty().Average();
                 
                //grab the existing rating and set the star rating to it 
                var userPreviousRating = (from r in db.Ratings
                                          where r.WalkID == walkID & r.AuthorID == user.UserProfileID
                                          select r.Score).SingleOrDefault();

                if (userPreviousRating > 0) { this.inputValue = userPreviousRating.ToString(); }

                //manage Favourite/Unfavourite buttons visibility
                  var userFavouriteWalks = user.DogWalks;

                  var result = userFavouriteWalks.SingleOrDefault(w => w.WalkID == walkID);
                  if (result == null)
                  {
                    LoginView3.FindControl("btnFavourite").Visible = true;
                    LoginView3.FindControl("btnUnFavourite").Visible = false;
                  }
                  else
                  {
                    LoginView3.FindControl("btnFavourite").Visible = false;
                    LoginView3.FindControl("btnUnFavourite").Visible = true;
                  }
              }
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

       return walk;
      }          
    }

    protected void FormView1_DataBound(object sender, EventArgs e)
    {
      if (FormView1.CurrentMode == FormViewMode.ReadOnly)
      {
        //Check the RowType to where the Control is placed
        if (FormView1.Row.RowType == DataControlRowType.DataRow)
        {
          //Just Changed the index of cells based on your requirement
          Label lbl = (Label)FormView1.Row.Cells[0].FindControl("lblCreatedBy");
          if (lbl != null)
          {
            var walk = int.Parse(Request.QueryString["WalkID"]);
            using (var db = new WalkContext())
            {
              var walkAuthorID = (from w in db.DogWalks
                                  where w.WalkID == walk
                                  select w.AuthorID).SingleOrDefault();

              var authorProfile = (from u in db.UserProfiles
                                   where u.UserProfileID == walkAuthorID
                                   select u).SingleOrDefault();

              //ensures each walk has a name
              string name = authorProfile.FirstName + " " + authorProfile.LastName;            
              lbl.Text = string.IsNullOrWhiteSpace(name) ? "user" + walkAuthorID : name;
            }
          }
        }
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
    public IQueryable CommentsListView_GetData()
    {
      using (var db = new WalkContext())
      {
        int id = Convert.ToInt32(Request.QueryString["WalkID"]);

        List<CommentsProfileModel> commentsProfile = new List<CommentsProfileModel>();

        //used for debugging purposes to count number of actual comments per walk
        //var walkComments = (from c in db.Comments
        //                    where c.WalkID == id
        //                    select c).ToList();

        var walkAnonymousResult = (from c in db.Comments
                                  join u in db.UserProfiles
                                    on c.AuthorID equals u.UserProfileID
                                  where c.WalkID == id
                                  select new
                                  {
                                    CommentID = c.CommentID,
                                    Title = c.Title,
                                    Body = c.Body,
                                    CreateDateTime = c.CreateDateTime,
                                    UserProfileID = u.UserProfileID,
                                    ProfilePicture = u.ProfilePicture,
                                    FirstName = u.FirstName,
                                    LastName = u.LastName,
                                  }).ToList();

        foreach (var i in walkAnonymousResult)
        {
          commentsProfile.Add(new CommentsProfileModel(i.CommentID, i.Title, i.Body, i.CreateDateTime, i.UserProfileID, i.ProfilePicture, i.FirstName, i.LastName));
        }

        if (commentsProfile.Count < 1)
        {
          LoginView1.FindControl("lbNoComments").Visible = true;
        }
        else
        {
          lblNumberOfComments.Text = commentsProfile.Count.ToString();
        }
        if (commentsProfile.Count != 1)
        {
          lblSingleOrPluralComments.Text = "s";
        }

         //sort the list before sending to listview (date descending)
        commentsProfile.Sort((x, y) => y.CreateDateTime.CompareTo(x.CreateDateTime));

        return commentsProfile.AsQueryable();
      }
    }
    
    public void CommentsListView_InsertItem([QueryString("WalkID")] int walkID)
    {
      var currentUserID = User.Identity.GetUserId();
      
      var comment = new DogWalks.DAL.Comment();

      TryUpdateModel(comment);
      if (ModelState.IsValid)
      {
        // Save changes here
        using(var db=new WalkContext())
        {          
          comment.WalkID = walkID;
          comment.CreateDateTime = DateTime.Now;

          var profile = (from u in db.UserProfiles
                         where u.FKUserID == currentUserID
                         select u).SingleOrDefault();
          
          comment.AuthorID = profile.UserProfileID;
          db.Comments.Add(comment);
          db.SaveChanges();
        }
        //Response.Redirect("WalkDetails?WalkID=" + walkID);       
      }
    }

    protected void btnFavourite_Click(object sender, EventArgs e)
    {
      using (var db = new WalkContext())
      {       
        var user = User.Identity.GetUserId();

        var userProfile = (from u in db.UserProfiles
                           where u.FKUserID == user
                           select u).Single();

        if (userProfile != null)
        {
          var walkID = Request.QueryString["WalkID"];
          int id;

          if (int.TryParse(walkID, out id)) 
          { 
            var walk = (from w in db.DogWalks
                        where w.WalkID == id
                        select w).Single();

            userProfile.DogWalks.Add(walk);
            db.SaveChanges();

            LoginView3.FindControl("btnFavourite").Visible = false;
            LoginView3.FindControl("btnUnFavourite").Visible = true;
          };
        }
      }
    }

    protected void btnUnFavourite_Click(object sender, EventArgs e)
    {
      using (var db = new WalkContext())
      {
        var user = User.Identity.GetUserId();

        var userProfile = (from u in db.UserProfiles
                           where u.FKUserID == user
                           select u).Single();

        if (userProfile != null)
        {
          var walkID = Request.QueryString["WalkID"];
          int id;
          if (int.TryParse(walkID, out id))
          { 
            var userFavouriteWalks = userProfile.DogWalks;
            var currentWalk = userFavouriteWalks.SingleOrDefault(w => w.WalkID == id);

            //user has favourited walk
            if (currentWalk != null)
            {
              userProfile.DogWalks.Remove(currentWalk);
              db.SaveChanges();

              LoginView3.FindControl("btnFavourite").Visible = true;
              LoginView3.FindControl("btnUnFavourite").Visible = false;
            }
          }
        }
      }
    }

  }
  
  //class used by commentslistview. Objects provide further details combining user profiles with their posted comments
  public class CommentsProfileModel
  {
    public int CommentID { get; set; }
    public string Title { get; set; }
    public string Body { get; set; }
    public DateTime CreateDateTime { get; set; }
    public int UserProfileID { get; set; }
    public string ProfilePicture { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }

    public CommentsProfileModel(int commentID, string title, string body, DateTime createDateTime, int userProfileID, string profilePicture, string firstName, string lastName)
    {
      this.CommentID = commentID;
      this.Title = title;
      this.Body = body;
      this.CreateDateTime = createDateTime;
      this.UserProfileID = userProfileID;
      this.ProfilePicture = profilePicture;
      this.FirstName = firstName;
      this.LastName = lastName;
    }
  }
}