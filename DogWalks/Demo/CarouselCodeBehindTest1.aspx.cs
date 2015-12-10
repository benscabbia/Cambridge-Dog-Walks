using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace DogWalks.Demo
{
  public partial class CarouselCodeBehindTest1 : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      DataTable dt = new DataTable();
      dt.Columns.AddRange(new DataColumn[1] { new DataColumn("ImageUrl") });
      dt.Rows.Add("http://static.flickr.com/66/199481236_dc98b5abb3_s.jpg");
      dt.Rows.Add("http://static.flickr.com/75/199481072_b4a0d09597_s.jpg");
      dt.Rows.Add("http://static.flickr.com/57/199481087_33ae73a8de_s.jpg");
      dt.Rows.Add("http://static.flickr.com/77/199481108_4359e6b971_s.jpg");
      dt.Rows.Add("http://static.flickr.com/58/199481143_3c148d9dd3_s.jpg");
      dt.Rows.Add("http://static.flickr.com/72/199481203_ad4cdcf109_s.jpg");
      dt.Rows.Add("http://static.flickr.com/58/199481218_264ce20da0_s.jpg");
      dt.Rows.Add("http://static.flickr.com/69/199481255_fdfe885f87_s.jpg");
      dt.Rows.Add("http://static.flickr.com/60/199480111_87d4cb3e38_s.jpg");
      dt.Rows.Add("http://static.flickr.com/70/229228324_08223b70fa_s.jpg");
      rptImages.DataSource = dt;
      rptImages.DataBind();
    }
  }
}