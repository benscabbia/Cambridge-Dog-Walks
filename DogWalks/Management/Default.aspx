<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DogWalks.Management.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <div class="row">
    <div class="col-md-12">
      <h2>Management Panel</h2>
      <br />
      <asp:Button ID="Button1" runat="server" Text="Manage Comments" class="btn btn-primary" PostBackUrl="ManageComments.aspx" />
      <asp:Button ID="Button2" runat="server" Text="Manage Features" class="btn btn-success" PostBackUrl="ManageFeatures.aspx" />
    </div>
  </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">  
</asp:Content>
