using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Linq.Expressions;
using System.Linq.Dynamic;

namespace DogWalks.Walks
{
  public partial class ListWalks : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }

    // The return type can be changed to IEnumerable, however to support
    // paging and sorting, the following parameters must be added:
    //     int maximumRows
    //     int startRowIndex
    //     out int totalRowCount
    //     string sortByExpression
    public IEnumerable<DogWalks.DAL.DogWalk> ListView1_GetData()
    {
      using (WalkContext db = new WalkContext())
      {
        //if searchbox has text in it
        if (!string.IsNullOrWhiteSpace(tbSearch.Text))
        {
          string searchValue = tbSearch.Text;
          var searchQuery = (from w in db.DogWalks.Include("Pictures")
                             where w.Title.Contains(searchValue)
                             select w).ToList();

          tbSearch.Text = "";//remove text
          return searchQuery;
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
          return query.ToList();
        }

      }

    }

    protected void CategoryList_SelectedIndexChanged(object sender, EventArgs e)
    {
      ListView1.DataBind();
    }

    //protected void btSearch_Click(object sender, EventArgs e)
    //{
    //  string searchValue = tbSearch.Text;
    //  if (!string.IsNullOrWhiteSpace(searchValue))
    //  {
    //    using (WalkContext db = new WalkContext())
    //    {
          
    //      var query = (from w in db.DogWalks.Include("Pictures")
    //                   //where w.Title.Contains(searchValue)
    //                   select w);

    //      if (query != null)
    //      {
    //        ListView1.DataSource = query;
    //        ListView1.DataBind();
    //      }
    //      //IQueryable<DogWalk> query = db.DogWalks.Include("Pictures").;

    //    }
    //  }
    //}
  }
}