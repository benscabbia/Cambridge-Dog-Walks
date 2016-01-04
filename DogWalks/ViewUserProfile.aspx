<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ViewUserProfile.aspx.cs" Inherits="DogWalks.ViewUserProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <asp:FormView ID="UserProfileFormView" runat="server" ItemType="DogWalks.DAL.UserProfile" SelectMethod="UserProfileFormView_GetItem">
    <ItemTemplate>
      <h1><%# Item.FirstName %></h1>
    </ItemTemplate>
  </asp:FormView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
