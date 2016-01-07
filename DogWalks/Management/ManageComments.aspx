<%@ Page Title="Manage Comments" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ManageComments.aspx.cs" Inherits="DogWalks.Management.ManageComments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
  <link href="../Management/management.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <div class="row">
    <div class="col-md-12">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CommentID" DataSourceID="EntityDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
          <asp:TemplateField HeaderText="Delete">
            <%--<EditItemTemplate>
              <asp:CheckBox ID="CheckBox1" runat="server" />
            </EditItemTemplate>--%>
            <ItemTemplate>
              <asp:CheckBox ID="CheckBox1" runat="server" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:CommandField ShowEditButton="True" HeaderText="Edit Comment" />
          <asp:BoundField DataField="CommentID" HeaderText="CommentID" ReadOnly="True" SortExpression="CommentID" />
          <asp:BoundField DataField="WalkID" HeaderText="WalkID" SortExpression="WalkID" />
          <asp:BoundField DataField="AuthorID" HeaderText="AuthorID" SortExpression="AuthorID" />
          <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
          <asp:BoundField DataField="Body" HeaderText="Body" SortExpression="Body" />
          <asp:BoundField DataField="CreateDateTime" HeaderText="CreateDateTime" SortExpression="CreateDateTime" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
      </asp:GridView>
      <br />
      <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" OnClick="btnDelete_Click"  />
    </div>
  </div>
  
  <asp:EntityDataSource ID="EntityDataSource1" runat="server" ConnectionString="name=WalkContext" DefaultContainerName="WalkContext" EnableDelete="True" EnableFlattening="False" EnableUpdate="True" EntitySetName="Comments" EntityTypeFilter="Comment">
  </asp:EntityDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContentChildFullWidth" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
