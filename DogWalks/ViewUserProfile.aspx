<%@ Page Title="View User Profile" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ViewUserProfile.aspx.cs" Inherits="DogWalks.ViewUserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <br />
  <h2><asp:Label ID="lblNotFound" runat="server" Text="User profile could not be found" Visible="true"></asp:Label></h2>
  <asp:Panel ID="PanelUserProfile" Visible="false" runat="server">
    <asp:FormView ID="UserProfileFormView" runat="server" ItemType="DogWalks.DAL.UserProfile" SelectMethod="UserProfileFormView_GetItem" OnDataBound="UserProfileFormView_DataBound">
      <ItemTemplate>
         <h2>User Profile</h2>
        <div class="row">
          <div class="col-md-3">
            <div class="thumbnail">
              <asp:Image ID="imgProfilePic" runat="server" ImageUrl='<%# Item.ProfilePicture != null ? Item.ProfilePicture : "~/SystemPics/no-image-profile.png" %>' />
            </div>
          </div>
          <div class="col-md-9">
         
            <br />
            <h5><b>Name: </b><%# Item.FirstName %> <%# Item.LastName%></h5>
            <h5><b>Member Since: </b><%# Eval("JoinDateTime", "{0:MM/dd/yyyy}") %></h5>
            <h5><b>Number of Comments: </b><asp:Label ID="lblNumOfComments" runat="server"></asp:Label></h5>
            <h5><b>About Me: </b></h5>
            <p><%# Item.AboutMe %></p>

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
