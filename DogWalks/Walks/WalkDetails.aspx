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

    .comments-background {
      background: #f5f5f5;
    }

    .comments-section-background{
      background:#565656;
      margin-bottom:-21px; /*required to cover part of the footer*/
    }

    .white-text{
      color: white;
    }
  </style>
  <br />
  <asp:FormView ID="FormView1" runat="server" ItemType="DogWalks.DAL.DogWalk" SelectMethod="FormView1_GetItem">
    <ItemTemplate>
     
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
              <p><asp:Label ID="lbPostcodeDistance" runat="server" Text='<%# "<b>Useful Website: </b>" + Item.WebsiteUrl %>' Visible=<%# (string.IsNullOrEmpty(Item.WebsiteUrl)) ? false : true %>></asp:Label> </p>
              <p><b>Created by: </b>user xxx on the <%# Item.CreateDateTime.ToShortDateString() %></p>
            </div>
          </div>
        </div>
      </div>

      <br />

      <div class="row">
        <div class="col-md-12">
          <b>Features: </b>
          <br />
          <asp:Repeater ID="Repeater4" runat="server" DataSource="<%# Item.Features %>">
            <ItemTemplate>
              <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PictureUrl") %>' />
              <%--<asp:Label ID="lbTest" runat="server" Text='<%# Eval("FeatureName") %>'></asp:Label>--%>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </ItemTemplate>
  </asp:FormView>
  <br /><br />
  <asp:Button ID="btnDelete" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Delete" OnClick="btnDelete_Click" />
  <br /><br />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
  <div class="comments-section-background">
    <div class="container">
          <h1 class="white-text">Comments</h1>

      <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate><h6 class="white-text">Sorry, you must be <a href="../Account/Login.aspx">logged in</a> to view discussion.</h6></AnonymousTemplate>
        <LoggedInTemplate>
          <asp:Label ID="lbNoComments" runat="server" Text="No Comments" Visible="false" CssClass="white-text"></asp:Label>
          <asp:ListView ID="ListView1" runat="server" DataKeyNames="CommentID" ItemType="DogWalks.DAL.Comment" SelectMethod="ListView1_GetData" InsertMethod="ListView1_InsertItem" insertitemposition="LastItem">
            <ItemTemplate>
              <div class="row">
                <div class="col-md-12">
                  <blockquote class="comments-background">
                    <h3><b><%# Item.Title %></b></h3>
                    <p><%# Item.Body %></p>
                    <p><small><%# Item.AuthorID %>Author Person, <%# Item.CreateDateTime.ToShortDateString() %></small></p>
                  </blockquote>
                </div>
              </div>
            </ItemTemplate>
            <InsertItemTemplate>
              <hr />
              <h2 class="white-text">Add Comment:</h2>
                <div class="form-horizontal">
                  <%--title--%>
                  <div class="form-group">
                    <asp:Label ID="Label1" runat="server" Text="Title" CssClass="control-label col-md-1 white-text"></asp:Label>
                    <div class="col-md-11">
                      <asp:TextBox ID="tbTitle" CssClass="form-control" Text="<%# BindItem.Title %>" runat="server"></asp:TextBox>
                    </div>
                  </div>

                  <%--comment--%>
                  <div class="form-group">
                    <asp:Label ID="Label2" runat="server" Text="Comment" CssClass="control-label col-md-1 white-text"></asp:Label>
                    <div class="col-md-11">
                      <asp:TextBox ID="tbBody" CssClass="form-control" Text="<%# BindItem.Body %>" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-md-offset-1 col-md-11">
                      <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Comment" CommandName="Insert" />
                    </div>
                  </div>
                </div>
            </InsertItemTemplate>           
          </asp:ListView>
        </LoggedInTemplate>
      </asp:LoginView>


        </div>
      </div>  
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
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
