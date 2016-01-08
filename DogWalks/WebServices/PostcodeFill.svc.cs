using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using DogWalks.DAL;

namespace DogWalks.WebServices
{
  [ServiceContract(Namespace = "")]
  [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
  public class PostcodeFill
  {
    // To use HTTP GET, add [WebGet] attribute. (Default ResponseFormat is WebMessageFormat.Json)
    // To create an operation that returns XML,
    //     add [WebGet(ResponseFormat=WebMessageFormat.Xml)],
    //     and include the following line in the operation body:
    //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
    [OperationContract]
    //Specifying message exchange format is JSON 
    [WebInvoke(ResponseFormat = WebMessageFormat.Json)]
    public List<string> GetPostcodes(string prefixText)
    {
      using (var db = new WalkContext())
      {
      var x = (from n in db.PostCodesUKs
              where n.Postcode.Substring(0, prefixText.Length).ToLower() == prefixText.ToLower()
              select n);

      List<string> postcode = new List<string>();
      foreach (var item in x)
      {
        postcode.Add(item.Postcode.ToString());
      }
      return postcode;
      }
      
    }

    // Add more operations here and mark them with [OperationContract]
  }
}
