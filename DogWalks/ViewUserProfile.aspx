<%@ Page Title="View User Profile" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ViewUserProfile.aspx.cs" Inherits="DogWalks.ViewUserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
  <style>
    .figurePadding{
      padding: 0 5px;
    }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <br />
  <h2><asp:Label ID="lblNotAuthenticated" runat="server" Text="Please login to view user" Visible="true"></asp:Label></h2>
  <h2><asp:Label ID="lblNotFound" runat="server" Text="User profile could not be found" Visible="true"></asp:Label></h2>
  <asp:Panel ID="PanelUserProfile" Visible="false" runat="server">
    <asp:FormView ID="UserProfileFormView" runat="server" ItemType="DogWalks.DAL.UserProfile" SelectMethod="UserProfileFormView_GetItem" OnDataBound="UserProfileFormView_DataBound">
      <ItemTemplate>
        <div class="row">
          
          <div class="col-md-3">
            <div class="thumbnail">
              <asp:Image ID="imgProfilePic" runat="server" ImageUrl='<%# Item.ProfilePicture != null ? Item.ProfilePicture : "~/SystemPics/no-image-profile.png" %>' />
            </div>
          </div>
          <div class="col-md-3">
         
            <h2>User Profile</h2>
            <h5><b>Name: </b><%# Item.FirstName %> <%# Item.LastName%></h5>
            <h5><b>Member Since: </b><%# Eval("JoinDateTime", "{0:dd/mm/yyyy}") %></h5>
            <h5><b>Number of Comments: </b><asp:Label ID="lblNumOfComments" runat="server"></asp:Label></h5>
            <h5><b>About Me: </b></h5>
            <p><%# Item.AboutMe %></p>

          </div>

          <div class="col-md-offset-2 col-md-4">
          <asp:Panel ID="PanelStats" Visible="true" runat="server">
            <div class="panel panel-primary">
              <div class="panel-heading">
                <h2>User Stats</h2>
              </div>
              <div class="panel-body">
               <h5><asp:Label ID="lblPropOfComments" CssClass="figurePadding" runat="server"></asp:Label> Proportion of Comments</h5>
                <hr />
               <h5><asp:Label ID="lblPropOfWalks" CssClass="figurePadding" runat="server"></asp:Label>Proportion of Dog Walks Uploaded</h5>
                <hr />
               <h5><asp:Label ID="lblPropOfRatings" CssClass="figurePadding" runat="server"></asp:Label>Proportion of Ratings given</h5>
                <hr />
                <div class="text-center">
                 <h5>Average Rating</h5>
                 <input id="starRating" type="number" class="rating" min="0" max="5" step="0.5" readonly="true" data-size="sm" runat="server">
                </div>
                <hr />
                <h5><asp:Label ID="lblUserRank" CssClass="figurePadding" runat="server"></asp:Label>User Rank</h5>
              </div>
            </div>
          </asp:Panel>

           <asp:Panel ID="PanelBlank" Visible="false" runat="server">
             <div class="panel panel-danger">
              <div class="panel-heading">
                <h2>Locked Feature</h2>
                </div>
                <div class="panel-body">
                  <h5>We value our users privacy.</h5>
                  <h5>To view other people's stats, you must have:</h5>
                  <ul>
                    <li><h5>at least 1 walk</h5></li>
                    <li><h5>at least 1 comments</h5></li>
                    <li><h5>at least 1 rating</h5></li>
                  </ul>        
                  
                  </div>
               </div>

           </asp:Panel>




          </div>

        </div>

        <div class="row">
          <div class="col-md-3">
            <h5><b>My Favourite Walks: </b>
            <br />
              <ul>
              <asp:Repeater ID="RepeaterFavouriteWalks" runat="server" ItemType="DogWalks.DAL.DogWalk">
                <ItemTemplate>
                   <li><a href='../Walks/WalkDetails?WalkID=<%#Item.WalkID %>'><%# Item.Title %></a></li>
                </ItemTemplate>
              </asp:Repeater>
                </ul>
            </h5>
            </div>
          <div class="col-md-3">
            <h5>
              <b>Uploaded Dog Walks: </b>
              <br />
              <ul>
                <asp:Repeater ID="RepeaterUploadedWalks" runat="server" ItemType="DogWalks.DAL.DogWalk">
                  <ItemTemplate>
                    <li><a href='../Walks/WalkDetails?WalkID=<%#Item.WalkID %>'><%# Item.Title %></a></li>
                  </ItemTemplate>
                </asp:Repeater>
              </ul>
            </h5>
          </div>
        </div>
      
      </ItemTemplate>
    </asp:FormView>

  </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
