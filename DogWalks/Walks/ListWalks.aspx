<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ListWalks.aspx.cs" Inherits="DogWalks.Walks.ListWalks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <h1>Let's find the perfect walk!</h1><br />

  <div class="row">
    <div class="col-md-3">
      <asp:DropDownList ID="CategoryList" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="CategoryList_SelectedIndexChanged">
        <asp:ListItem Enabled="False" Value="0">Sort By</asp:ListItem>
        <asp:ListItem Value="1">Title</asp:ListItem>
        <asp:ListItem Selected="True" Value="2">Date Created</asp:ListItem>
        <asp:ListItem Value="3">Length</asp:ListItem>
        <asp:ListItem Enabled="False" Value="4">Average Rating</asp:ListItem>
        <asp:ListItem Value="5">Postcode Search</asp:ListItem>
      </asp:DropDownList>
    </div>

    <asp:Panel ID="PanelSearch" Visible="true" runat="server">
      <div class="col-md-3">
        <asp:DropDownList ID="SortOrder" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="CategoryList_SelectedIndexChanged">
          <asp:ListItem Value="ASC" Selected="True">Ascending</asp:ListItem>
          <asp:ListItem Value="DESC">Descending</asp:ListItem>
        </asp:DropDownList>
      </div>

      <div class="col-md-6">
        <%--<div class="row">
        <div class="col-md-7" >--%>
        <div class="input-group">
          <asp:TextBox ID="tbSearch" CssClass="form-control" placeholder="Search for..." runat="server"></asp:TextBox>
          <span class="input-group-btn">
            <asp:Button ID="btSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="CategoryList_SelectedIndexChanged" />
          </span>
        </div>
      </div>

    </asp:Panel>

    <%--Logic is still TODO--%>
    <asp:Panel ID="PanelPostcode" runat="server" Visible="false">
      <div class="col-md-5">
        <asp:TextBox ID="tbPostcode" CssClass="form-control" runat="server" placeholder="Enter Postcode"></asp:TextBox>
      </div>
      <div class="col-md-4">        
        <div class="input-group">
          <asp:DropDownList ID="RadiusList" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="CategoryList_SelectedIndexChanged">
          <asp:ListItem Value="5">5 miles</asp:ListItem>
          <asp:ListItem Value="10">10 miles</asp:ListItem>
          <asp:ListItem Value="15">15 miles</asp:ListItem>
          <asp:ListItem Value="20">20 miles</asp:ListItem>
          <asp:ListItem Value="30">30 miles</asp:ListItem>
          <asp:ListItem Value="40">40 miles</asp:ListItem>
          <asp:ListItem Value="50">50 miles</asp:ListItem>
        </asp:DropDownList>          
          <span class="input-group-btn">
            <asp:Button ID="btPostCostSearch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="CategoryList_SelectedIndexChanged" />
          </span>
        </div>       
      </div>      
    </asp:Panel>
  </div> 

  <br />
  <asp:Label ID="lbNoDogwalks" runat="server" Text="Sorry, we could not find any dog walks within the radius" Visible="false"></asp:Label>
  
  <asp:ListView ID="ListView1" runat="server" ItemType="DogWalks.Walks.InRangeWalks" SelectMethod="ListView1_GetData" >
    <ItemTemplate>
      <div class="row">
        <div class="col-md-3">
          <div class="thumbnail">
            <a href="../Walks/WalkDetails?WalkID=<%# Item.Walk.WalkID %>">             
            <asp:Image ID="Image1" runat="server" ImageUrl=<%# Item.Walk.Pictures.FirstOrDefault() != null ? Item.Walk.Pictures.FirstOrDefault().PictureUrl : string.Empty %>/>
          </a>
          </div>          
        </div>

        <div class="col-md-9">
          <a href="../Walks/WalkDetails?WalkID=<%# Item.Walk.WalkID %>"><h3><b><%# Item.Walk.Title %></b></h3></a>
          <h6><b>Location:</b> <%# Item.Walk.Location%>, <%# Item.Walk.Postcode%></h6>
          <%--Had to apply 'fake space' to avoid exception if description is <300--%>
          <p><%# Item.Walk.Description.ToString().PadRight(300).Substring(0,300).TrimEnd()%> . . .</p>
          <h6><b>Created on:</b> <%# Item.Walk.CreateDateTime.ToString() %></h6>
          <h6><asp:Label ID="lbPostcodeDistance" runat="server" Text='<%# "<b>Distance from Postcode:</b> " + Item.DistanceFromPostcode.ToString("0.##") + " miles" %>' Visible=<%# (Item.DistanceFromPostcode == -1 || string.IsNullOrEmpty(tbPostcode.Text)) ? false : true %>></asp:Label> </h6>          
        </div>
      </div>
    </ItemTemplate>

    <ItemSeparatorTemplate>
      <hr>
    </ItemSeparatorTemplate>

    <EmptyDataTemplate>
      <h3>No results found</h3>
    </EmptyDataTemplate>
  </asp:ListView>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
