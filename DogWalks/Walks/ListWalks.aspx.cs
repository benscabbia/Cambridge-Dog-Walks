using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Linq.Expressions;
using System.Linq.Dynamic;
using DogWalks.App_Code;

namespace DogWalks.Walks
{
  public partial class ListWalks : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if(!IsPostBack)
      {
        var queryString = Request.QueryString["Filter"];
        int filter;
        int catIndex = -1;

        if(!string.IsNullOrEmpty(queryString) && int.TryParse(queryString, out filter))
        {
          switch (filter)
          {
            //newest walks
            case 1: 
              catIndex = 2;
              break;      
        
            //top rated walks 
            case 2:
              catIndex = 4;
              break;

            //longest walks
            case 3:
              catIndex = 3;
              break;

            //Postcode search
            case 4:
              catIndex = 5;
              break;

            //Alphabetically
            case 5:
              catIndex = 1;
              break;
          }
        }
        if(catIndex > 0 && catIndex <=5)
        {
          CategoryList.SelectedIndex = catIndex;

          if (CategoryList.SelectedIndex == 5)
          {
            PanelSearch.Visible = false;
            PanelPostcode.Visible = true;
          }
          else
          {
            PanelPostcode.Visible = false;
            PanelSearch.Visible = true;
            tbPostcode.Text = "";

            if (CategoryList.SelectedIndex == 2) SortOrder.SelectedIndex = 1;
            if (CategoryList.SelectedIndex == 3) SortOrder.SelectedIndex = 1;
          }
        }
      }

      if (IsPostBack)
      {
        if (CategoryList.SelectedIndex == 5)
        {
          PanelSearch.Visible = false;
          PanelPostcode.Visible = true;
        }
        else 
        { 
          PanelPostcode.Visible = false;
          PanelSearch.Visible = true;
          tbPostcode.Text = "";
        }

      }
    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression

    public IQueryable<InRangeWalks> ListView1_GetData()    
    {
      using (WalkContext db = new WalkContext())
      {
        //if postcodebox has text in it
        if(!string.IsNullOrEmpty(tbPostcode.Text))
        {
          //clear textbox as precaution
          tbSearch.Text = "";

          string postcode = tbPostcode.Text.ToLower().Replace(" ", "");
          int radius = Int32.Parse(RadiusList.SelectedValue);

          var postcodeCoords = (from p in db.PostCodesUKs
                                where p.PostcodeNoSpace == postcode
                                select p).SingleOrDefault();

          if (postcodeCoords == null)
          {
            lbNoDogwalks.Text = "The postcode entered could not be found, please try another";
            lbNoDogwalks.Visible = true;
            return null;
          }
          else
          {

            double userPostcodeLat = (double)postcodeCoords.Latitude;
            double userPostcodeLong = (double)postcodeCoords.Longitude;

            //grab all dogwalks in system
            List<DogWalk> grabAllWalks = (from w in db.DogWalks.Include("Pictures").Include("Length")
                                          select w).ToList();
            
            var inRangeWalks = new List<InRangeWalks>();            
            foreach (var walk in grabAllWalks)
            {
              //method params: distanceCalculator(user lat, user long, walk lat, walk long, metric system )
              double walkLat = (double)walk.Latitude;
              double walkLong = (double)walk.Longitude;

              double dis = DistanceCalculator.distanceCalculator(userPostcodeLat, userPostcodeLong, walkLat, walkLong, 'M');
              if (dis <= radius)
              {
                float averageRatings = (float)(from r in db.Ratings
                                               where r.WalkID == walk.WalkID
                                               select r.Score).DefaultIfEmpty().Average();

                inRangeWalks.Add(new InRangeWalks(dis, walk, averageRatings));
              }
            }

            if (inRangeWalks.Count < 1)
            {
              lbNoDogwalks.Text = "Sorry, we could not find any dog walks within the radius";
              lbNoDogwalks.Visible = true;
            }
            else
            {
              lbNoDogwalks.Visible = false;
              //sort the array
              inRangeWalks.Sort((x, y) => x.DistanceFromPostcode.CompareTo(y.DistanceFromPostcode));
            }
            //tbPostcode.Text = "";
            //return inRangeWalks.Select(x => x.Walk);        
            return inRangeWalks.AsQueryable();        
          }
        }
        
        //if searchbox has text in it
        else if (!string.IsNullOrWhiteSpace(tbSearch.Text))
        {
          string searchValue = tbSearch.Text;
          var searchQuery = (from w in db.DogWalks.Include("Pictures").Include("Length")
                             where w.Title.Contains(searchValue)
                             select w).ToList();

          var inRangeWalks = new List<InRangeWalks>();
          foreach (var walk in searchQuery)
          {
            float averageRatings = (float)(from r in db.Ratings
                                           where r.WalkID == walk.WalkID
                                           select r.Score).DefaultIfEmpty().Average();

            inRangeWalks.Add(new InRangeWalks(-1, walk, averageRatings));
          }

          tbSearch.Text = "";//remove text
          return inRangeWalks.AsQueryable();        
        }

        else
        {
          int categoryList = Convert.ToInt32(CategoryList.SelectedValue);
          string order = SortOrder.SelectedValue;

          IQueryable<DogWalk> query = db.DogWalks.Include("Pictures").Include("Length");

          //0=sortby, 1=title, 2=create time, 3=length, 4=average rating
          switch (categoryList)
          {
            case 1:
              query = query.AsQueryable().OrderBy("Title " + order);
              break;
            case 2:
              query = query.AsQueryable().OrderBy("CreateDateTime " + order);
              break;
            case 3:
              query = query.AsQueryable().OrderBy("Length.SizeRank " + order);
              break;
          }
          var inRangeWalks = new List<InRangeWalks>();
          
          foreach (var walk in query)
          {            
            float averageRatings = (float)(from r in db.Ratings
                                  where r.WalkID == walk.WalkID
                                  select r.Score).DefaultIfEmpty().Average();

            inRangeWalks.Add(new InRangeWalks(-1, walk, averageRatings));
          }

          //order by ratings
          if (categoryList == 4)
          {
            if (order == "DESC") return inRangeWalks.AsQueryable().OrderBy(C => C.AverageRating);
            return inRangeWalks.AsQueryable().OrderByDescending(C => C.AverageRating);
          }
         return inRangeWalks.AsQueryable();
        }
      }
    }

    //method is also used by RadiusList
    protected void CategoryList_SelectedIndexChanged(object sender, EventArgs e)
    {
      ListView1.DataBind();
    }

    protected void ListView1_DataBound(object sender, ListViewItemEventArgs e)
    {
      if (e.Item.ItemType == ListViewItemType.DataItem)
      {
        var lbUploadedBy = (Label)e.Item.FindControl("lbUploadedBy");
        if (lbUploadedBy != null)
        {
          using (var db = new WalkContext())
          {
            InRangeWalks currentWalk = (InRangeWalks)e.Item.DataItem;            
            var author = db.UserProfiles.Where(u => u.UserProfileID == currentWalk.Walk.AuthorID).SingleOrDefault();
            lbUploadedBy.Text = "<a href='" + "../ViewUserProfile?UserProfileID=" + author.UserProfileID + "'>" + author.FirstName + " " + author.LastName + "</a>";
          }
        }
      }    
    }

  }

  //used to temporarily store walks with the relative distance to the inputted postcode
  public class InRangeWalks
  {
    private double distanceFromPostcode;
    private DogWalk walk;
    private float averageRating;

    public InRangeWalks(DogWalk walk)
    {
      this.walk = walk;
    }
    public InRangeWalks(double distanceFromPostcode, DogWalk walk)
    {
      this.distanceFromPostcode = distanceFromPostcode;
      this.walk = walk;
    }
    public InRangeWalks(double distanceFromPostcode, DogWalk walk, float averageRating)
    {
      this.distanceFromPostcode = distanceFromPostcode;
      this.walk = walk;
      this.averageRating = averageRating;
    }

    public double DistanceFromPostcode { get { return distanceFromPostcode; } }
    public DogWalk Walk { get { return walk; } }
    public double AverageRating { get { return averageRating; } }
  }
}