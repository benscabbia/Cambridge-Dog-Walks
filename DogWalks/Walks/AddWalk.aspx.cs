using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using Microsoft.AspNet.Identity;

namespace DogWalks.Walks
{
  public partial class AddWalk : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      Form.Enctype = "multipart/form-data";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
      using (WalkContext db = new WalkContext())
      {
        DogWalk dogWalk = new DogWalk();
        dogWalk.Title = tbTitle.Text;
        dogWalk.Description = tbDescription.Text;
        dogWalk.LengthID = Convert.ToInt32(LengthList.SelectedValue);
        dogWalk.Location = tbLocation.Text;
        dogWalk.WebsiteUrl = tbWebsite.Text;

        //get user ID from UserProfiles table
        var userID = User.Identity.GetUserId();
        var profileID = (from u in db.UserProfiles
                      where u.FKUserID == userID
                      select u).Single();
        dogWalk.AuthorID = profileID.UserProfileID;

        TagLogic(db, dogWalk);
        ImageLogic(dogWalk);               
        PostCodeLogic(db, dogWalk);

        dogWalk.CreateDateTime = DateTime.Now;
        dogWalk.UpdateDateTime = dogWalk.CreateDateTime;

        db.DogWalks.Add(dogWalk);
        db.SaveChanges();
        Response.Redirect("~/Walks/ListWalks.aspx");
      }
    }

    //method which contains image logic
    private void ImageLogic(DogWalk dogWalk)
    {
      //HttpPostedFile myFile2 = Request.Files["myFile"];

      for (int i = 0; i < Request.Files.Count; i++)
      {
        HttpPostedFile image = Request.Files[i];
        if (image.ContentLength > 0)
        {
          //var image = file.FileName;
          Picture picture = new Picture(); //create new picture

          picture.WalkID = dogWalk.WalkID; //assign image the dogwalk id

          string virtualFolder = "~/WalkPics/";
          string physicalFolder = Server.MapPath(virtualFolder);
          string fileName = Guid.NewGuid().ToString();
          string extension = System.IO.Path.GetExtension(image.FileName);

          image.SaveAs(System.IO.Path.Combine(physicalFolder, fileName + extension));  //save image on local

          picture.PictureUrl = virtualFolder + fileName + extension; //set picture url
         
          picture.Description = "an image of the walk"; //set description (temp)

          dogWalk.Pictures.Add(picture); //add the image to pictures
        }
      }
    }

    //method which contains tag logic
    private void TagLogic(WalkContext db, DogWalk dogWalk)
    {
      List<int> selectedTags = new List<int>();
      foreach (ListItem item in cblTags.Items)
      {
        if (item.Selected)
        {
          selectedTags.Add(int.Parse(item.Value));
        }
      }

      string tagitem = "";
      foreach (var item in selectedTags)
      {
        tagitem += item + ", ";
        dogWalk.Features.Add(db.Features.FirstOrDefault(i => i.FeatureID == item));

      }
      lbConsole.Text = tagitem;
    }

    //method which contains postcode logic
    private void PostCodeLogic(WalkContext db, DogWalk dogWalk)
    {
      //convert any postcode to no-space, lowercase format
      string postcode = tbPostcode.Text.ToLower().Replace(" ", "");
      //get postcode coordinates
      var postCodeCoords = (from p in db.PostCodesUKs
                            where p.PostcodeNoSpace == postcode
                            select p).SingleOrDefault();

      decimal postcodeLat = postCodeCoords.Latitude;
      decimal postcodeLong = postCodeCoords.Longitude;

      dogWalk.Postcode = postCodeCoords.Postcode; //correctly formatted postcode
      dogWalk.Latitude = postcodeLat;
      dogWalk.Longitude = postcodeLong;
    }

    public IEnumerable<Feature> TagList_GetData()
    {
      using (WalkContext db = new WalkContext())
      {
        var query = (from f in db.Features
                     select f).ToList();
        return query;
      }
    }

    public IEnumerable<Length> LengthList_GetData()
    {
      WalkContext db = new WalkContext();
      
        var query = (from l in db.Lengths
                     orderby l.SizeRank
                     select l);

        lbLengthDescription.Text = 
                    (from l in db.Lengths
                    orderby l.SizeRank
                    where l.LengthID==1
                    select l.Description).Single(); 

        return query;
      
      
    }

    protected void LengthList_SelectedIndexChanged(object sender, EventArgs e)
    {
      DropDownList list = (DropDownList) sender;
      int selected = Convert.ToInt32(list.SelectedValue);
      using(WalkContext db = new WalkContext())
      {
        var query = (from l in db.Lengths
                       where l.LengthID == selected
                       select l.Description).Single();
        lbLengthDescription.Text = query;
      }

    }  
  }
}

//IEnumerable is suitable just for iterate through collection and you can not modify (Add or Remove) data IEnumerable bring ALL data from server to client then 
//filter them, assume that you have a lot of records so IEnumerable puts overhead on your memory.Whenever we encounter to huge data with so many records so we 
//have to reduce overhead from application. 

//IQueryable prepares high performance in such situations (huge data) by filtering data firstly and then sending filtered data to client.

//http://stackoverflow.com/questions/1196007/linq-get-all-selected-values-of-a-checkboxlist-using-a-lambda-expression
//IEnumerable<int> allChecked = chkBoxList.Items
//                              .Cast<ListItem>()
//                              .Where(item => item.Selected)
//                              .Select(item => int.Parse(item.Value));


//List<ListItem> selectedTags = cblTags.Items.Cast<ListItem>()
//  .Where(li => li.Selected)
//  .Select(li => li.Value).ToList();-