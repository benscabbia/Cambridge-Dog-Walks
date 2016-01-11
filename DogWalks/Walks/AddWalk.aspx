<%@ Page Title="Add Walk" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="AddWalk.aspx.cs" Inherits="DogWalks.Walks.AddWalk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContentChild" runat="server">
  <link href="../Content/AddWalkStyle.css" rel="stylesheet" />
  <script src="../Scripts/jasny-bootstrap.js"></script>
  <link href="../Content/jasny-bootstrap.min.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentChild" runat="server">
  <asp:UpdatePanel runat="server">
    <ContentTemplate>
      <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Services>
          <asp:ServiceReference Path="~/WebServices/PostcodeFill.svc" />
        </Services>
      </asp:ScriptManagerProxy>

      <h2>Insert New Dog Walk</h2>

      <br />

      <div class="form-horizontal">
        <%--title--%>
        <div class="form-group">
          <asp:Label ID="Label1" runat="server" Text="Title*" CssClass="control-label col-md-1" AssociatedControlID="tbTitle"></asp:Label>
          <div class="col-md-11">
            <asp:TextBox ID="tbTitle" CssClass="form-control setMaxWidth" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbTitle" ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter a Title" Text="You Must add a title" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationGroup="NewWalkValidationGroup" ID="RegularExpressionValidator1" ControlToValidate="tbTitle" runat="server" ErrorMessage="Title cannot be more than 100 characters" ValidationExpression="^[\s\S]{0,100}$" Text="Maximum 100 characters for the title" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
          </div>
        </div>
        <%--description--%>
        <div class="form-group">
          <asp:Label ID="lbDescription" runat="server" Text="Description*" CssClass="control-label col-md-1" AssociatedControlID="tbDescription"></asp:Label>
          <div class="col-md-11">
            <asp:TextBox ID="tbDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control setMaxWidth"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbDescription" ErrorMessage="Enter a Description" Text="You Must add a Description" ID="RequiredFieldValidator2" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbDescription" ErrorMessage="Description cannot be more than 1000 characters" Text="Maximum 1000 characters for the Description" ValidationExpression="^[\s\S]{0,1000}$" ID="RegularExpressionValidator2" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
          </div>
        </div>
        <%--length--%>
        <div class="form-group">
          <asp:Label ID="lbLength" runat="server" Text="Length*" CssClass="control-label col-md-1" AssociatedControlID="LengthList"></asp:Label>
          <div class="col-md-4">
            <asp:DropDownList ID="LengthList" runat="server" SelectMethod="LengthList_GetData" OnSelectedIndexChanged="LengthList_SelectedIndexChanged" AutoPostBack="true"
              CssClass="form-control setMaxWidth" DataTextField="LengthName" DataValueField="LengthID">
            </asp:DropDownList>
          </div>
          <asp:Label ID="lbLengthDescription" runat="server" Text="Label" CssClass="col-md-7 control-label leftAlign"></asp:Label>
        </div>
        <%--location--%>
        <div class="form-group">
          <asp:Label ID="lbLocation" runat="server" Text="Location*" CssClass="control-label col-md-1" AssociatedControlID="tbLocation"></asp:Label>
          <div class="col-md-11">
            <asp:TextBox ID="tbLocation" runat="server" TextMode="MultiLine" CssClass="form-control setMaxWidth"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbLocation" ErrorMessage="Enter a Location" Text="You Must add a Location" ID="RequiredFieldValidator4" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbLocation" ErrorMessage="Location cannot be more than 250 characters" Text="Maximum 250 characters for the Description" ValidationExpression="^[\s\S]{0,250}$" ID="RegularExpressionValidator4" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
          </div>
        </div>
        <%--postcode--%>
        <div class="form-group">
          <asp:Label ID="lbPostcode" runat="server" Text="Postcode*" CssClass="control-label col-md-1" AssociatedControlID="tbPostcode"></asp:Label>
          <div class="col-md-11">
            <asp:TextBox ID="tbPostcode" runat="server" CssClass="form-control setMaxWidth"></asp:TextBox>
            <asp:RequiredFieldValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbPostcode" ErrorMessage="Enter a Postcode" Text="You Must add a Postcode" ID="RequiredFieldValidator3" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbPostcode" ErrorMessage="Postcode must be valid" Text="Postcode must be valid" ValidationExpression="(?:[A-Za-z]\d ?\d[A-Za-z]{2})|(?:[A-Za-z][A-Za-z\d]\d ?\d[A-Za-z]{2})|(?:[A-Za-z]{2}\d{2} ?\d[A-Za-z]{2})|(?:[A-Za-z]\d[A-Za-z] ?\d[A-Za-z]{2})|(?:[A-Za-z]{2}\d[A-Za-z] ?\d[A-Za-z]{2})" ID="RegularExpressionValidator3" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
          </div>
        </div>
        <%--tags--%>
        <div class="form-group">
          <asp:Label ID="lbTags" runat="server" Text="Tags" CssClass="control-label col-md-1"></asp:Label>
          <div class="col-md-11">
            <asp:CheckBoxList ID="cblTags" SelectMethod="TagList_GetData" runat="server" DataTextField="FeatureName" DataValueField="FeatureID"
              RepeatDirection="Horizontal" CssClass="checkboxListSpacing" RepeatColumns="5">
            </asp:CheckBoxList>
          </div>
        </div>
        <%--websiteUrl--%>
        <div class="form-group">
          <asp:Label ID="Label2" runat="server" Text="Website Link" CssClass="control-label col-md-1" AssociatedControlID="tbWebsite"></asp:Label>
          <div class="col-md-11">
            <asp:TextBox ID="tbWebsite" runat="server" CssClass="form-control setMaxWidth" TextMode="Url"></asp:TextBox>
            <asp:RegularExpressionValidator ValidationGroup="NewWalkValidationGroup" ControlToValidate="tbWebsite" ErrorMessage="URL must be valid. Must be in form of: http://mywebsite.com or www.mywebsite.com" Text="Website must be valid. Must be in form of: http://mywebsite.com or www.mywebsite.com" ValidationExpression="(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})" ID="RegularExpressionValidator5" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
          </div>
        </div>
        <%--image--%>
        <div class="form-group">
          <asp:Label ID="lbImage" runat="server" Text="Image" CssClass="control-label col-md-1"></asp:Label>
          <div class="col-md-11">
            <div class="fileinput fileinput-new setMaxWidth" data-provides="fileinput">
              <div class="input-group">
                <div class="form-control uneditable-input">
                  <i class="glyphicon glyphicon-file fileinput-exists"></i>
                  <span class="fileinput-filename"></span>
                </div>
                <div class="input-group-btn">
                  <div class="btn btn-default btn-file">
                    <span class="fileinput-new">Select</span>
                    <span class="fileinput-exists">Change</span>
                    <input type="file" id="myFile" name="myFile" multiple="multiple">
                  </div>
                  <button type="button" class="btn btn-default fileinput-exists" data-dismiss="fileinput" title="remove">
                    Remove
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <%--  submit--%>
        <div class="form-group">
          <div class="col-md-offset-1 col-md-11">
            <asp:Button ValidationGroup="NewWalkValidationGroup" ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Walk" OnClick="btnSave_Click" />
          </div>
        </div>
        <div class="row">
          <div class="col-md-offset-1 col-md-11">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errorMessage" />
          </div>
        </div>
      </div>
      <br />

      <asp:Label ID="lbConsole" runat="server" Text="Label" Visible="false"></asp:Label>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="btnSave" />
    </Triggers>
  </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContentChild" runat="server">
  <script>
    $(function () {
      $(document).on('change.bs.fileinput', '.fileinput', function (e) {
        var $this = $(this),
            $input = $this.find('input[type=file]'),
            $span = $this.find('.fileinput-filename');
        if ($input[0].files !== undefined && $input[0].files.length > 1) {
          $span.addClass('dropdown').html('<a href="#" data-toggle="dropdown" class="dropdown-toggle">multiple files selected <i class="caret"></i></a><ul class="dropdown-menu" role="menu"><li>' + $.map($input[0].files, function (val) { return val.name; }).join('</li><li>') + '</li></ul>');
        } else if ($input[0].files !== undefined && $input[0].files.length == 1) {
          $span.removeClass('dropdown').html($.map($input[0].files, function (val) { return val.name; }));
        }
      });
    });
  </script>
</asp:Content>
