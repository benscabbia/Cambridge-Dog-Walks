<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="CarouselTest2.aspx.cs" Inherits="DogWalks.Demo.CarouselTest2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
  
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <style type="text/css">
    .carousel {
      background: #2f4357;
      margin-top: 20px;
    }

      .carousel .item img {
        margin: 0 auto; /* Align slide image horizontally center */
      }

    .carousel-inner > .item > img, .carousel-inner > .item > a > img {
      width: 100%;
      max-height: 500px;
    }

    .bs-example {
      margin: 20px;
    }
  </style>

  <div class="container">
    <div class="bs-example">
      <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <!-- Carousel indicators -->
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <!-- Wrapper for carousel items -->
        <div class="carousel-inner">
          <div class="item active">
            <img src="http://i.imgur.com/Chu6k6D.jpg" alt="First Slide">
          </div>
          <div class="item">
            <img src="http://i.imgur.com/dFDlWGO.jpg" alt="Second Slide">
          </div>
          <div class="item">
            <img src="http://i.imgur.com/XLRA67N.jpg" alt="Third Slide">
          </div>
        </div>
        <!-- Carousel controls -->
        <a class="carousel-control left" href="#myCarousel" data-slide="prev">
          <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="carousel-control right" href="#myCarousel" data-slide="next">
          <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
      </div>
    </div>

  </div>
</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
  <%--  <script>
    $('.carousel').carousel({
      interval: 3000
    })
  </script>--%>
</asp:Content>
