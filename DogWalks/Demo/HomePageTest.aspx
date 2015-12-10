<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePageTest.aspx.cs" Inherits="DogWalks.Demo.HomePageTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <link href="../Content/bootstrap.min.css" rel="stylesheet" />
  <link href="../Content/homeStyle.css" rel="stylesheet" />
  <link href="StyleSheet1.css" rel="stylesheet" />
  <script src="../Scripts/bootstrap.min.js"></script>
  <script src="../Scripts/jquery-1.10.2.min.js"></script>
  <script src="../Scripts/jquery-1.10.2.intellisense.js"></script>
  <script src="../Scripts/modernizr-2.6.2.js"></script>
  <script src="../Scripts/respond.min.js"></script>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>
  <!--based on http://www.bootply.com/1eqrl9iKKj-->
  <div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">Cambs Dog Walks</a>
      </div>
      <div class="collapse navbar-collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="#">Home</a></li>
          <li><a href="#two">About</a></li>
          <li><a href="#three">Contact</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
          <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        </ul>
      </div>
      <!--/.nav-collapse -->
    </div>
  </div>

  <div id="background" class="container-full-bg" style="background-image: url('http://i.imgur.com/ZmGZFcA.jpg');
 /*-webkit-filter: blur(5px) grayscale(50%);*/ -webkit-filter: brightness(70%); "></div>
    <div class="container special">

      <div class="row">
        <div class="Absolute-Center is-Responsive text-center">


          <h1 class="title-text">It's time for a walk.</h1>
          <h4 class=" text-white">Let us find you the perfect walk.</h4>
          <br />
          <form runat="server">
            <a href="#middle">incase</a><asp:Button ID="Button1" runat="server" Text="Find a Walk" CssClass="btn btn-success btn-lg"/>
          </form>
        </div>
      </div>

    </div>

</body>
</html>

