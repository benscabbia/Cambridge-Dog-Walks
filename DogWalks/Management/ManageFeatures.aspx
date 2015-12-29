<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="ManageFeatures.aspx.cs" Inherits="DogWalks.Management.ManageFeatures" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
    <link href="../Management/management.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="FeatureID" EmptyDataText="No Features to display" AllowPaging="True" PageSize="50" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
      <asp:TemplateField ShowHeader="false">
        <EditItemTemplate>
          <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
          &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
        </EditItemTemplate>

        <ItemTemplate>
          <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
          &nbsp;<asp:LinkButton ID="DeleteLink" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
        </ItemTemplate>
        <ItemStyle Width="100px" />
      </asp:TemplateField>             
      <asp:ImageField DataImageUrlField="PictureUrl" >
        <ControlStyle Height="100px" Width="100px" />
      </asp:ImageField>
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

  <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" DataSourceID="SqlDataSource1" AutoGenerateRows="false" DataKeyNames="FeatureID" DefaultMode="Insert" >
    <Fields>
      <asp:BoundField DataField="FeatureID" HeaderText="FeatureID" InsertVisible="False" ReadOnly="True" SortExpression="FeatureID" />
      <asp:BoundField DataField="FeatureName" HeaderText="FeatureName" SortExpression="FeatureName" />
      <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
      <asp:BoundField DataField="PictureUrl" HeaderText="PictureUrl" SortExpression="PictureUrl" />
      <asp:CommandField ShowInsertButton="True" />
    </Fields>
    
  </asp:DetailsView>



  <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="Data Source=jose.cs.herts.ac.uk;Initial Catalog=dbbs13acd;Persist Security Info=True;User ID=bs13acd;Password=R0dL8Hmr;MultipleActiveResultSets=True;Application Name=EntityFramework" DeleteCommand="DELETE FROM [Feature] WHERE [FeatureID] = @original_FeatureID AND [FeatureName] = @original_FeatureName AND (([Description] = @original_Description) OR ([Description] IS NULL AND @original_Description IS NULL)) AND (([PictureUrl] = @original_PictureUrl) OR ([PictureUrl] IS NULL AND @original_PictureUrl IS NULL))" InsertCommand="INSERT INTO [Feature] ([FeatureName], [Description], [PictureUrl]) VALUES (@FeatureName, @Description, @PictureUrl)" OldValuesParameterFormatString="original_{0}" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [FeatureID], [FeatureName], [Description], [PictureUrl] FROM [Feature] ORDER BY [FeatureID]" UpdateCommand="UPDATE [Feature] SET [FeatureName] = @FeatureName, [Description] = @Description, [PictureUrl] = @PictureUrl WHERE [FeatureID] = @original_FeatureID AND [FeatureName] = @original_FeatureName AND (([Description] = @original_Description) OR ([Description] IS NULL AND @original_Description IS NULL)) AND (([PictureUrl] = @original_PictureUrl) OR ([PictureUrl] IS NULL AND @original_PictureUrl IS NULL))">
    <DeleteParameters>
      <asp:Parameter Name="original_FeatureID" Type="Int32" />
      <asp:Parameter Name="original_FeatureName" Type="String" />
      <asp:Parameter Name="original_Description" Type="String" />
      <asp:Parameter Name="original_PictureUrl" Type="String" />
    </DeleteParameters>
    <InsertParameters>
      <asp:Parameter Name="FeatureName" Type="String" />
      <asp:Parameter Name="Description" Type="String" />
      <asp:Parameter Name="PictureUrl" Type="String" />
    </InsertParameters>
    <UpdateParameters>
      <asp:Parameter Name="FeatureName" Type="String" />
      <asp:Parameter Name="Description" Type="String" />
      <asp:Parameter Name="PictureUrl" Type="String" />
      <asp:Parameter Name="original_FeatureID" Type="Int32" />
      <asp:Parameter Name="original_FeatureName" Type="String" />
      <asp:Parameter Name="original_Description" Type="String" />
      <asp:Parameter Name="original_PictureUrl" Type="String" />
    </UpdateParameters>
  </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
