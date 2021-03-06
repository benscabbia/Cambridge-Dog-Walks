﻿<%@ Page Title="Walk Details" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="WalkDetails.aspx.cs" Inherits="DogWalks.Walks.WalkDetail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">  
  <link href="../Content/WalkDetailStyle.css" rel="stylesheet" />
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <br />
  
  <asp:FormView ID="FormView1" runat="server" ItemType="DogWalks.DAL.DogWalk" SelectMethod="FormView1_GetItem" OnDataBound="FormView1_DataBound">
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

        </div>
        <div class="col-md-7">
          <div class="row">
            <div class="col-md-7"><h1><%#Item.Title %></h1></div>
           <br /><br />
              <div class="col-md-5"><input id="starRating2" value="<%# GetAverageWalkScore() %>" type="number" class="rating" min="0" max="5" step="0.5" readonly="true" data-size="xs"></div>
          </div>
          
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
              <p><a href="<%# Item.WebsiteUrl %>"><asp:Label ID="lbPostcodeDistance" runat="server" Text='<%# Item.WebsiteUrl%>' Visible=<%# (string.IsNullOrEmpty(Item.WebsiteUrl)) ? false : true %>></asp:Label></a> </p>
              <p><b>Created by: </b><a href="../ViewUserProfile?UserProfileID=<%# Item.AuthorID %>"><asp:Label ID="lblCreatedBy" runat="server"></asp:Label></a>, on the <%# Item.CreateDateTime.ToShortDateString() %></p>
            </div>
          </div>
        </div>
      </div>

      <br />
      <hr />
      <%--features--%>
      <div class="row">
        <div class="col-md-12 text-center">
          <br />
          <asp:Repeater ID="Repeater4" runat="server" DataSource="<%# Item.Features %>">
            <ItemTemplate>
              <div class="feature-container">
                <span class="feature-img-style">
                  <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("PictureUrl") %>' />
                </span>
                <span class="caption">
                  <p><%# Eval("FeatureName") %></p>
                </span>
              </div>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </div>
    </ItemTemplate>
  </asp:FormView>

  <%--rating--%>
  <%--add walk to favourites and star rating system--%>
  <div class="row">
    <div class="col-md-12">
      <asp:LoginView ID="LoginView3" runat="server">
        <LoggedInTemplate> 
          <br />
          <asp:Panel ID="PanelStarRating" Visible="true" runat="server">
            <div class="col-md-offset-4 col-md-8">
              <input id="starRating" type="number" class="rating" min="0" max="5" step="0.5" data-size="lg" value="<%= inputValue %>">
            </div>
          </asp:Panel>

          <asp:UpdatePanel runat="server">
            <ContentTemplate>
              <div class="row text-center">
                <asp:Button ID="btnFavourite" runat="server" Text="Add to Favourite" CssClass="btn btn-success btn-lg" OnClick="btnFavourite_Click" />
                <asp:Button ID="btnUnFavourite" runat="server" Text="Unfavourite" CssClass="btn btn-warning btn-lg" OnClick="btnUnFavourite_Click" />
              </div>
            </ContentTemplate>
          </asp:UpdatePanel>
        </LoggedInTemplate>
      </asp:LoginView>
    </div>
  </div>

  <hr />

  <div class="row text-center">
    <div class="col-md-12">
      <asp:LoginView ID="LoginView4" runat="server">
        <LoggedInTemplate>
          <h2>You  might also like...</h2>
        </LoggedInTemplate>
        <AnonymousTemplate>
          <h2>Please login to rate this walk, add it to your favourites or get walk recommendations!</h2>
        </AnonymousTemplate>
      </asp:LoginView>
      
      <%--Repeater doesn't need to be in login view since it's only binded if user authenticated--%>
      <asp:Repeater ID="ReapeaterYouMightLike" runat="server">
        <ItemTemplate>
          <div class="might-also-like-feature-container">
            <span class="might-also-like-img-style">
              <a href="../Walks/WalkDetails?WalkID=<%# Eval("WalkID") %>">
                <asp:Image ID="Image1" runat="server" ImageUrl=<%# Get_MightAlsoLikeImageUrl((Object)Eval("Pictures")) %> />
              </a>
            </span>
            <span class="caption">
              <p><a href="../Walks/WalkDetails?WalkID=<%# Eval("WalkID") %>"><%# Eval("Title") %></a></p>
            </span>
          </div>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </div>

  <br />
  <hr />
  <div class="row">
    <div class="col-md-12 text-center">
      <h2>Share this walk!</h2>
      <a href='https://www.facebook.com/sharer/sharer.php?u=<%=Request.Url.ToString()%>' target="_blank">
        <input type="button" value="Share on Facebook" class="btn btn-primary" />
      </a>
      <a href="https://plus.google.com/share?url=<%=Request.Url.ToString()%>" target="_blank">
        <input type="button" value="Share on Google+" class="btn btn-danger" />
      </a>
      <a href="https://twitter.com/share" class="twitter-share-button" target="_blank">
        <input type="button" value="Share on Twitter" class="btn btn-info" />
      </a>
      <a href="mailto:?subject=I wanted you to see this walk&amp;body=Check out this walk <%=Request.Url.ToString()%>." title="Share by Email"" target="_blank">
        <input type="button" value="Share by email" class="btn btn-default" />
      </a>
    </div>
  </div>

  <asp:LoginView ID="LoginView2" runat="server">
        <RoleGroups>
          <%--admin--%>
          <asp:RoleGroup Roles="Administrator">
            <ContentTemplate>
              <br /><br />
              <asp:Button ID="btnDelete" CssClass="btn btn-danger" CausesValidation="false" runat="server" Text="Delete" OnClick="btnDelete_Click" />
              <br /><br />
            </ContentTemplate>
          </asp:RoleGroup>
          <%--moderator--%>
        </RoleGroups>
      </asp:LoginView>

  <br />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
  <asp:UpdatePanel runat="server">
    <ContentTemplate>
      <div class="comments-section-background">
        <div class="container">
          <h1 class="white-text">
            <asp:Label ID="lblNumberOfComments" runat="server"></asp:Label>
            Comment<asp:Label ID="lblSingleOrPluralComments" runat="server"></asp:Label>
          </h1>

          <asp:LoginView ID="LoginView1" runat="server">
            <AnonymousTemplate>
              <h6 class="white-text">Sorry, you must be <a href="../Account/Login.aspx">logged in</a> to view discussion.</h6>
            </AnonymousTemplate>
            <LoggedInTemplate>
              <asp:Label ID="lbNoComments" runat="server" Text="No Comments" Visible="false" CssClass="white-text"></asp:Label>
              <asp:ListView ID="ListView1" runat="server" DataKeyNames="CommentID" ItemType="DogWalks.Walks.CommentsProfileModel" SelectMethod="CommentsListView_GetData" InsertMethod="CommentsListView_InsertItem" InsertItemPosition="LastItem">
                <ItemTemplate>
                  <div class="row">
                    <div class="col-md-12 comments-background center-profile-image">
                      <div class="col-md-2 center-profile-image">
                        <div class="center-profile-image ">
                          <div class="thumbnail profile-img-max-width">
                            <a href="../ViewUserProfile?UserProfileID=<%# Item.UserProfileID %>">
                              <asp:Image ID="Image3" runat="server" ImageUrl='<%# Item.ProfilePicture != null ? Item.ProfilePicture : "~/SystemPics/no-image-profile.png" %>' /></a>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-10 center-profile-image">
                        <h3><b><%# Item.Title %></b></h3>
                        <p><%# Item.Body %></p>
                        <p><small><a href="../ViewUserProfile?UserProfileID=<%# Item.UserProfileID %>"><%# Item.FirstName %> <%# Item.LastName %></a>, <%# Item.CreateDateTime.ToShortDateString() %></small></p>
                      </div>
                    </div>
                  </div>
                  <br />
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

    </ContentTemplate>
  </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
  <%--<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    <Services>--%>
      <%--<asp:ServiceReference Path="~/WebServices/SaveRatingService.svc" />--%>
<%--      <asp:ServiceReference Path="https://jose.cs.herts.ac.uk/bs13acd/final/Walks/bs13acd/final/WebServices/SaveRatingService.svc" />--%>
      
   <%-- </Services>
  </asp:ScriptManagerProxy>--%>

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

    //used by star rating
    $(document).ready(function () {      
      $("#starRating").rating();
      //alert("hello");
    });

    
      $("#starRating").on('rating.change', function (event, value, caption) {
        var walkID = getUrlVars()["WalkID"];

        var score = $('#starRating').val();
        window.UserID = '<%=HttpUtility.JavaScriptStringEncode(this.User.Identity.GetUserId())%>';

        //alert("walkid:" + walkID + ", score:" + score + ", ID: " + window.UserID);
        <%--var loggedinuserid = "<%=loggedInUserId%>";--%>
        //var loggedinUserID = "abc";
        //save rating using service
        //SaveRatingService.Save(score, walkID, loggedinuserid);
        //SaveRatingService.Save(score, walkID, window.UserID);

        $.get("SaveRating.aspx",
          {
            Score: score,
            WalkID: walkID,
          });
      });
    

    //function to get query string
    function getUrlVars() {
      var vars = [], hash;
      var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
      for (var i = 0; i < hashes.length; i++) {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
      }
      return vars;
    }      
  </script>
</asp:Content>
