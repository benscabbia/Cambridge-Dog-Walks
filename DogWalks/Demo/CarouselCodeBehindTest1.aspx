<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CarouselCodeBehindTest1.aspx.cs" Inherits="DogWalks.Demo.CarouselCodeBehindTest1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
</head>
<body>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://cdn.jsdelivr.net/jcarousel/0.2.8/jquery.jcarousel.min.js"></script>
    <link href="http://cdn.jsdelivr.net/jcarousel/0.2.8/skins/tango/skin.css" rel="Stylesheet" />
  <form id="form1" runat="server">
    <div>
      <script type="text/javascript">
        $(function () {
          $('#mycarousel').jcarousel();
        });
      </script>


      <ul id="mycarousel" class="jcarousel-skin-tango">
        <asp:Repeater ID="rptImages" runat="server">
          <ItemTemplate>
            <li>
              <img alt="" style='height: 75px; width: 75px' src='<%# Eval("ImageUrl") %>' />
            </li>
          </ItemTemplate>
        </asp:Repeater>
      </ul>
    </div>
  </form>
</body>
</html>
