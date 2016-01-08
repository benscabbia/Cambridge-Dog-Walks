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
    public IQueryable<string> GetPostcodes(string prefixText)
    {
      using (var db = new WalkContext())
      {
        var formatted = prefixText.Replace(" ", "").ToLower();

        var x = (from n in db.PostCodesUKs
                 where n.PostcodeNoSpace.Substring(0, prefixText.Length).ToLower() == formatted
                 select n.Postcode).Take(20);

        List<string> postcode = new List<string>();
        foreach (var item in x)
        {
          postcode.Add(item.ToString());
        }
        return postcode.AsQueryable();
      }
    }

    // Add more operations here and mark them with [OperationContract]
  }
}
