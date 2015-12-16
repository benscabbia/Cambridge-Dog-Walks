using System;
using System.IO;
using System.Net;
using System.Web;
using System.Xml;

namespace DogWalks.App_Code
{
  public class DistanceCalculator
  {/// <summary>
    /// returns driving distance in miles
    /// </summary>
    /// <param name="origin"></param>
    /// <param name="destination"></param>
    /// <returns></returns>
    public static double GetDrivingDistanceInMiles(string origin, string destination)
    {
      string url = @"http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" +
        origin + "&destinations=" + destination +
        "&mode=driving&sensor=false&language=en-EN&units=imperial";

      HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
      WebResponse response = request.GetResponse();
      Stream dataStream = response.GetResponseStream();
      StreamReader sreader = new StreamReader(dataStream);
      string responsereader = sreader.ReadToEnd();
      response.Close();

      XmlDocument xmldoc = new XmlDocument();
      xmldoc.LoadXml(responsereader);


      if (xmldoc.GetElementsByTagName("status")[0].ChildNodes[0].InnerText == "OK")
      {
        XmlNodeList distance = xmldoc.GetElementsByTagName("distance");
        return Convert.ToDouble(distance[0].ChildNodes[1].InnerText.Replace(" mi", ""));
      }

      return 0;
    }

    /// <summary>
    /// returns driving distance in kilometers
    /// </summary>
    /// <param name="origin"></param>
    /// <param name="destination"></param>
    /// <returns></returns>
    public static double GetDrivingDistanceInKilometers(string origin, string destination)
    {
      string url = @"http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" +
        origin + "&destinations=" + destination +
        "&mode=driving&sensor=false&language=en-EN&units=metric";

      HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
      WebResponse response = request.GetResponse();
      Stream dataStream = response.GetResponseStream();
      StreamReader sreader = new StreamReader(dataStream);
      string responsereader = sreader.ReadToEnd();
      response.Close();

      XmlDocument xmldoc = new XmlDocument();
      xmldoc.LoadXml(responsereader);


      if (xmldoc.GetElementsByTagName("status")[0].ChildNodes[0].InnerText == "OK")
      {
        XmlNodeList distance = xmldoc.GetElementsByTagName("distance");
        return Convert.ToDouble(distance[0].ChildNodes[1].InnerText.Replace(" km", ""));
      }

      return 0;
    }

    public static double distanceCalculator(double lat1, double lon1, double lat2, double lon2, char unit)
    {
      double theta = lon1 - lon2;
      double dist = Math.Sin(deg2rad(lat1)) * Math.Sin(deg2rad(lat2)) + Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) * Math.Cos(deg2rad(theta));
      dist = Math.Acos(dist);
      dist = rad2deg(dist);
      dist = dist * 60 * 1.1515;
      if (unit == 'K')
      {
        dist = dist * 1.609344;
      }
      else if (unit == 'N')
      {
        dist = dist * 0.8684;
      }
      return (dist);
    }

    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    //::  This function converts decimal degrees to radians             :::
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    private static double deg2rad(double deg)
    {
      return (deg * Math.PI / 180.0);
    }

    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    //::  This function converts radians to decimal degrees             :::
    //:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    private static double rad2deg(double rad)
    {
      return (rad / Math.PI * 180.0);
    }

    /// <summary>
    /// returns latitude 
    /// </summary>
    /// <param name="addresspoint"></param>
    /// <returns></returns>
    public static double GetCoordinatesLat(string addresspoint)
    {
      using (var client = new WebClient())
      {
        string seachurl = "http://maps.google.com/maps/geo?q='" + addresspoint + "'&output=csv";
        string[] geocodeInfo = client.DownloadString(seachurl).Split(',');
        return (Convert.ToDouble(geocodeInfo[2]));
      }
    }

    /// <summary>
    /// returns longitude 
    /// </summary>
    /// <param name="addresspoint"></param>
    /// <returns></returns>
    public static double GetCoordinatesLng(string addresspoint)
    {
      using (var client = new WebClient())
      {
        string seachurl = "http://maps.google.com/maps/geo?q='" + addresspoint + "'&output=csv";
        string[] geocodeInfo = client.DownloadString(seachurl).Split(',');
        return (Convert.ToDouble(geocodeInfo[3]));
      }
    }
  }
}
