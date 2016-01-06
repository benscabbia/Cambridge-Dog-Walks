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
            List<DogWalk> grabAllWalks = (from w in db.DogWalks.Include("Pictures")
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
                inRangeWalks.Add(new InRangeWalks(dis, walk));
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
          var searchQuery = (from w in db.DogWalks.Include("Pictures")
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

          IQueryable<DogWalk> query = db.DogWalks.Include("Pictures");

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
         return inRangeWalks.AsQueryable();
        }
      }
    }

    //method is also used by RadiusList
    protected void CategoryList_SelectedIndexChanged(object sender, EventArgs e)
    {
      ListView1.DataBind();
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