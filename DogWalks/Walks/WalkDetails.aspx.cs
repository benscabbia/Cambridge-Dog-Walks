﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Web.ModelBinding;

namespace DogWalks.Walks
{
  public partial class WalkDetail : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
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
  }
}