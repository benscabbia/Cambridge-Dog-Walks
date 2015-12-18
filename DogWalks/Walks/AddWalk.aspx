<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="AddWalk.aspx.cs" Inherits="DogWalks.Walks.AddWalk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
  <style type="text/css">
    /*.auto-style1 {
      height: 16px;
    }

    .auto-style2 {
      height: 21px;
    }*/
    .setMaxWidth{
      max-width: 280px;
    }
    .leftAlign{
      text-align:left !important;
    }

  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <h2>Insert New Dog Walk</h2>

  <br />
  
  <div class="form-horizontal">
    <%--title--%>
    <div class="form-group">
      <asp:Label ID="Label1" runat="server" Text="Title" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbTitle" CssClass="form-control setMaxWidth" runat="server"></asp:TextBox>
      </div>
    </div>
    <%--description--%>
    <div class="form-group">
      <asp:Label ID="lbDescription" runat="server" Text="Description" CssClass="control-label col-md-1 "></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbDescription" runat="server" TextMode="MultiLine" Height="50px" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
    <%--length--%>
    <div class="form-group">
      <asp:Label ID="lbLength" runat="server" Text="Length" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-4">
        <asp:DropDownList ID="LengthList" runat="server" SelectMethod="LengthList_GetData" OnSelectedIndexChanged="LengthList_SelectedIndexChanged" AutoPostBack="true"
          CssClass="form-control setMaxWidth" DataTextField="LengthName" DataValueField="LengthID">
        </asp:DropDownList>
      </div>
      <asp:Label ID="lbLengthDescription" runat="server" Text="Label" CssClass="col-md-7 control-label leftAlign"></asp:Label>
    </div>
    <%--location--%>
    <div class="form-group">
      <asp:Label ID="lbLocation" runat="server" Text="Location" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbLocation" runat="server" TextMode="MultiLine" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
    <%--postcode--%>
    <div class="form-group">
      <asp:Label ID="lbPostcode" runat="server" Text="Postcode" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbPostcode" runat="server" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
    <%--tags--%>
    <div class="form-group">
      <asp:Label ID="lbTags" runat="server" Text="Tags" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:CheckBoxList ID="cblTags" SelectMethod="TagList_GetData" runat="server" DataTextField="FeatureName" DataValueField="FeatureID" RepeatDirection="Horizontal" CssClass="form-control">
        </asp:CheckBoxList>
      </div>
    </div>
    <%--image--%>
    <div class="form-group">
      <asp:Label ID="lbImage" runat="server" Text="Image" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" CssClass="form-control " />
      </div>
    </div>
    <%--  submit--%>
    <div class="form-group">
      <div class="col-md-offset-1 col-md-11">
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Walk" OnClick="btnSave_Click" />
      </div>
    </div>
  </div>

  <%--Bootstrap new form--%>
  <%--<div class="row">
    <div class="form-group">
      <asp:Label ID="Label1" runat="server" Text="Title" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbTitle" CssClass="form-control setMaxWidth" runat="server"></asp:TextBox>
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbDescription" runat="server" Text="Description" CssClass="control-label col-md-1 "></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbDescription" runat="server" TextMode="MultiLine" Height="50px" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbLength" runat="server" Text="Length" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-4">
        <asp:DropDownList ID="LengthList" runat="server" SelectMethod="LengthList_GetData" OnSelectedIndexChanged="LengthList_SelectedIndexChanged" AutoPostBack="true" 
          CssClass="form-control setMaxWidth" DataTextField="LengthName" DataValueField="LengthID"></asp:DropDownList>
      </div>
      <div class="col-md-7"><asp:Label ID="lbLengthDescription" runat="server" Text="Label"></asp:Label></div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbLocation" runat="server" Text="Location" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbLocation" runat="server" TextMode="MultiLine" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbPostcode" runat="server" Text="Postcode" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbPostcode" runat="server" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbTags" runat="server" Text="Tags" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:CheckBoxList ID="cblTags" SelectMethod="TagList_GetData" runat="server" DataTextField="FeatureName" DataValueField="FeatureID" RepeatDirection="Horizontal">
        </asp:CheckBoxList>
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <asp:Label ID="lbImage" runat="server" Text="Image" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" />
      </div>
    </div>
  </div>
  <br />
  <div class="row">
    <div class="form-group">
      <div class="col-md-1"></div>
      <div class="col-md-11">
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Walk" OnClick="btnSave_Click" />
      </div>
    </div>
  </div>--%>
  <br />

  <asp:Label ID="lbConsole" runat="server" Text="Label" Visible="false"></asp:Label>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
</asp:Content>
