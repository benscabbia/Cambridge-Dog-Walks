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

    .checkboxListSpacing td {
      padding:0 20px 2px 0;
    }
    .checkboxListSpacing label{
      padding-left: 2px;
    }

    /* made select/change button have round corner */
    /*used by jasny form upload*/
    .fileinput-new .input-group .input-group-btn .btn.btn-file {
      -webkit-border-radius: 0 4px 4px 0;
      -moz-border-radius: 0 4px 4px 0;
      border-radius: 0 4px 4px 0;
    }

    .fileinput .fileinput-filename {
      overflow: visible;
    }

      .fileinput .fileinput-filename .dropdown-menu > li {
        padding: 3px 20px;
      }


  </style>

  <%--<link href="http://cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/css/jasny-bootstrap.css" rel="stylesheet" />
  <script src="http://cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.js"></script>--%>
  <script src="../Scripts/jasny-bootstrap.min.js"></script>
  <link href="../Content/jasny-bootstrap.min.css" rel="stylesheet" />

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
        <asp:CheckBoxList ID="cblTags" SelectMethod="TagList_GetData" runat="server" DataTextField="FeatureName" DataValueField="FeatureID" 
          RepeatDirection="Horizontal" CssClass="checkboxListSpacing" RepeatColumns="5" >
        </asp:CheckBoxList>
      </div>
    </div>
    <%--websiteUrl--%>
    <div class="form-group">
      <asp:Label ID="Label2" runat="server" Text="Website Link" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <asp:TextBox ID="tbWebsite" runat="server" CssClass="form-control setMaxWidth"></asp:TextBox>
      </div>
    </div>
    <%--image--%>
    <div class="form-group">
      <asp:Label ID="lbImage" runat="server" Text="Image" CssClass="control-label col-md-1"></asp:Label>
      <div class="col-md-11">
        <div class="fileinput fileinput-new setMaxWidth" data-provides="fileinput">
          <div class="input-group">
            <div class="form-control uneditable-input">
              <i class="glyphicon glyphicon-file fileinput-exists"></i><span class="fileinput-filename"></span>
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
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Walk" OnClick="btnSave_Click" />
      </div>
    </div>
  </div>
  <br />

  <asp:Label ID="lbConsole" runat="server" Text="Label" Visible="false"></asp:Label>

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
