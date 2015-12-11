<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="WalkDetails.aspx.cs" Inherits="DogWalks.Walks.WalkDetail" %>

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
      width: 490px;
      height: 257px;
      /*Above 100% width, below image constraints maintained*/
      /*width: auto;
      height: 250px;
      max-height: 250px;*/
    }

    .bs-example {
      margin: 20px;
    }
  </style>
  <br />
  <asp:FormView ID="FormView1" runat="server" ItemType="DogWalks.DAL.DogWalk" SelectMethod="FormView1_GetItem">
    <ItemTemplate>
      <%--<div class="row">
        <div class="container">
          <div class="bs-example">
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
              <!-- Carousel indicators -->
              <%--<ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
              </ol>--%>
      <!-- Wrapper for carousel items -->
      <%--<div class="carousel-inner">
                <asp:Repeater ID="Repeater2" runat="server" DataSource="<%# Item.Pictures %>">
                  <ItemTemplate>
                    <div id="carousel-items" class="item">
                      <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("PictureUrl") %>' />
                    </div>
                  </ItemTemplate>
                </asp:Repeater>
                <!-- Carousel controls -->
              </div>
              <a class="carousel-control left" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left"></span>
              </a>
              <a class="carousel-control right" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
              </a>
            </div>
          </div>
        </div>
      </div>--%>      


      <div class="row">
        <div class="col-md-5">
          <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <%--carousel current slide graphic--%>
            <ol class="carousel-indicators">
              <asp:Repeater ID="Repeater2" runat="server" DataSource="<%# Item.Pictures %>">
                <ItemTemplate>
                  <li data-target="#myCarousel" data-slide-to="0"></li>
                </ItemTemplate>
              </asp:Repeater>
            </ol>

            <%--carousel images--%>
            <div class="carousel-inner">
              <asp:Repeater ID="Repeater3" runat="server" DataSource="<%# Item.Pictures %>">
                <ItemTemplate>
                  <div id="carousel-items" class="item">
                      <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("PictureUrl") %>' />
                                         
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
            <!-- Carousel previous and next button controls -->
            <a class="carousel-control left" href="#myCarousel" data-slide="prev">
              <span class="glyphicon glyphicon-chevron-left"></span>
            </a>
            <a class="carousel-control right" href="#myCarousel" data-slide="next">
              <span class="glyphicon glyphicon-chevron-right"></span>
            </a>
          </div>

          <%--          <div class="thumbnail">
            <asp:Image ID="Image2" runat="server" ImageUrl="<%# Item.Pictures.FirstOrDefault() != null ? Item.Pictures.FirstOrDefault().PictureUrl : string.Empty %>" />
          </div>--%>
        </div>
        <div class="col-md-7">
          <h1><%#Item.Title %></h1>
          <p><%# Item.Location %>, <%# Item.Postcode %></p>
          <hr />
          <h5 style="line-height: 1.2"><%# Item.Description %></h5>
          <hr />
          <div class="row">
            <div class="col-md-12">
              <p><b>Walk Distance:</b> <%#Item.Length.LengthName%> - <i><%#Item.Length.Description%></i></p>
              <p>
                <b>Features: </b>
                <asp:Repeater ID="Repeater1" runat="server" DataSource="<%# Item.Features %>">
                  <ItemTemplate>
                    <asp:Label ID="lbTest" runat="server" Text='<%# Eval("FeatureName") %>'></asp:Label>
                    , 
                  </ItemTemplate>
                </asp:Repeater>
              </p>
              <p><b>Created by: </b>user xxx on the <%# Item.CreateDateTime.ToShortDateString() %></p>
            </div>
          </div>
        </div>
      </div>
      <br />
      <div class="row">
        <div class="col-md-12">
          <b>Features: </b><br />
          <asp:Repeater ID="Repeater4" runat="server" DataSource="<%# Item.Features %>">
            <ItemTemplate>
              <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PictureUrl") %>'/>              
              <%--<asp:Label ID="lbTest" runat="server" Text='<%# Eval("FeatureName") %>'></asp:Label>--%>               
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
      <br /><br /><br /><br />
      <asp:Button ID="btnDelete" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Delete" OnClick="btnDelete_Click" />
    </ItemTemplate>
  </asp:FormView>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
  <script type="text/javascript">
    $('#myCarousel').carousel({
      interval: 10000
    });

    //used to set the data-slide-to property
    var i = 0;
    $(".carousel-indicators li").each(function () {
      $(this).attr("data-slide-to", i++);
    });

    //add active class to first slide (needed to load carousel correctly)
    $(function () {
      $('#carousel-items:first-child ').addClass('active');
      $('.carousel-indicators li:first-child').addClass('active');
    });
  </script>
</asp:Content>
