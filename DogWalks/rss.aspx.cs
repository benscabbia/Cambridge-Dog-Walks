using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DogWalks.DAL;
using System.Text;
using System.Xml;
using System.Net.NetworkInformation;
using System.Net;

namespace DogWalks
{
  public partial class rss : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      using (WalkContext db = new WalkContext())
      {
        var walks = (from w in db.DogWalks.Include("Features")
                     select w).ToList();

        Response.Clear(); //new request
        Response.ContentType = "text/xml"; //set the type
        //write xml
        XmlTextWriter TextWriter = new XmlTextWriter(Response.OutputStream, Encoding.UTF8);
        TextWriter.WriteStartDocument();

        //mandatory rss tag
        TextWriter.WriteStartElement("rss");
        TextWriter.WriteAttributeString("version", "2.0");

        string host = FullyQualifiedApplicationPath;
        //string address = "/bs13acd/final/Walks/WalkDetails?WalkID=";
        string address = "Walks/WalkDetails?WalkID=";

        //channel tag containg rss feed details - Can do: title,link,description,copywrite 
        TextWriter.WriteStartElement("channel");
        TextWriter.WriteElementString("title", "Cambridge Dog Walks RSS Feed");        
        TextWriter.WriteElementString("description", "Subscribe to our RSS feed to receive instant updates on every dog walk that is added to our site");
        TextWriter.WriteElementString("link", FormatForXML(host));                                                     
              
        foreach (var item in walks)
        {
        //item tag can do: title, link, descrioption, guid (unique identifier), pubDate
          TextWriter.WriteStartElement("item");
          TextWriter.WriteElementString("title", FormatForXML(item.Title));
          TextWriter.WriteElementString("description", FormatForXML(item.Description));
          TextWriter.WriteElementString("link", host + address + FormatForXML(item.WalkID));
          TextWriter.WriteElementString("guid", host + address + FormatForXML(item.WalkID));

          TextWriter.WriteElementString("pubDate", FormatForXML(Convert.ToDateTime(item.CreateDateTime.ToString("r"))));           
          TextWriter.WriteEndElement();
        }
        TextWriter.WriteEndElement();
        TextWriter.WriteEndElement();
        TextWriter.WriteEndDocument();
        TextWriter.Flush();
        TextWriter.Close();
        Response.End();
      }
    }
    //method to format text to xml
    protected string FormatForXML(object input)
    {
      string data = input.ToString();      // cast the input to a string

      // replace those characters disallowed in XML documents
      data = data.Replace("&", "&amp;");
      data = data.Replace("\"", "&quot;");
      data = data.Replace("'", "&apos;");
      data = data.Replace("<", "&lt;");
      data = data.Replace(">", "&gt;");

      return data;
    }

    //method to get relative url
    public string FullyQualifiedApplicationPath
    {
      get
      {
        //Return variable declaration
        var appPath = string.Empty;

        //Getting the current context of HTTP request
        var context = HttpContext.Current;

        //Checking the current context content
        if (context != null)
        {
          //Formatting the fully qualified website url/name
          appPath = string.Format("{0}://{1}{2}{3}",
                                  context.Request.Url.Scheme,
                                  context.Request.Url.Host,
                                  context.Request.Url.Port == 80
                                      ? string.Empty
                                      : ":" + context.Request.Url.Port,
                                  context.Request.ApplicationPath);
        }

        if (!appPath.EndsWith("/"))
          appPath += "/";

        return appPath;
      }
    }
  }
}