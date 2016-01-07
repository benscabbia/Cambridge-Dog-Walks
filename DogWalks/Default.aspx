<%@ Page Title="Default" Language="C#" MasterPageFile="~/MasterPages/Frontend.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DogWalks.Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="Content/defaultPageStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <%--first section part 1--%>
  <div id="background" class="container-full-bg" style="background-image: url('../HomePagePics/home-cover.jpg'); -webkit-filter: brightness(70%);"></div>
  <div class="container special">
    <div class="row">
      <div class="Absolute-Center is-Responsive text-center">
        <h1 class="title-text">It's time for a walk.</h1>
        <h4 class="text-white">Let us find you the perfect walk.</h4>
        <br />
        <a href="#middle" class="scroll btn btn-success btn-lg">Find a Walk</a>
      </div>
    </div>
  </div>

  <%--middle section part 2--%>
  <div id="middle" class="container">
    <h1 class="text-center">Let's find a great walk!</h1>
    <div class="row">
      <div class="col-sm-6 col-md-4">
        <div id="newestWalks" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/newest-walks.jpg" />
          <div class="caption text-center">
            <h3>Newest Walks</h3>
            <p><a href="../Walks/ListWalks?Filter=1" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div id="topRatedWalks" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/top-rated-walks.jpg" />
          <div class="caption text-center">
            <h3>Top Rated Walks</h3>
            <p><a href="../Walks/ListWalks?Filter=2" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>

      <div class="col-sm-6 col-md-4">
        <div id="longestWalks" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/longest-walks.jpg" />
          <div class="caption text-center">
            <h3>Longest Walks</h3>
            <p><a href="../Walks/ListWalks?Filter=3" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="container">
    <%--bottom section part 3--%>
    <div id="bottom" class="row">
      <div class="col-sm-6 col-md-4">
        <div id="postCodeRadius" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/postcode-search.jpg" />
          <div class="caption text-center">
            <h3>Postcode Radius Search</h3>
            <p><a href="../Walks/ListWalks?Filter=4" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div id="searchAlpha" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/search-alphabetically.jpg" />
          <div class="caption text-center">
            <h3>Search Alphabetically</h3>
            <p><a href="../Walks/ListWalks?Filter=5" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div id="viewAllWalks" class="thumbnail category">
          <img style="height: 200px; width: 100%; display: block;" src="HomePagePics/view-all-walks.jpg" />
          <div class="caption text-center">
            <h3>View all Walks</h3>
            <p><a href="../Walks/ListWalks.aspx" class="btn btn-success" role="button">Load Walks</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContent" runat="server">
   <script  type="text/javascript">
     //smooth scrolling
     $(document).ready(function () {
       $(".scroll").click(function (event) {
         event.preventDefault();
         $('html,body').animate({ scrollTop: $(this.hash).offset().top - 30 }, 'slow');
       });

       $('#newestWalks').click(function () {
         window.location = "../Walks/ListWalks?Filter=1";
       });
       $('#topRatedWalks').click(function () {
         window.location = "../Walks/ListWalks?Filter=2"
       });
       $('#longestWalks').click(function () {
         window.location = "../Walks/ListWalks?Filter=3"
       });
       $('#postCodeRadius').click(function () {
         window.location = "../Walks/ListWalks?Filter=4"
       });
       $('#searchAlpha').click(function () {
         window.location = "../Walks/ListWalks?Filter=5"
       });
       $('#viewAllWalks').click(function () {
         window.location = "../Walks/ListWalks.aspx"
       });
     });
  </script>
</asp:Content>