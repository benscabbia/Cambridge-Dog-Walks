<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="DogWalks.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="HeadContentChild" runat="server">
  <script src="../Scripts/jasny-bootstrap.js"></script>
  <link href="../Content/jasny-bootstrap.min.css" rel="stylesheet" />
  <link href="../Content/ManageStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentChild" runat="server">
  <h2><%: Title %>.</h2>
  <asp:UpdatePanel runat="server">
    <ContentTemplate>

      <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
          <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
      </div>

      <asp:Panel ID="updatedPanel" runat="server" Visible="false">
        <asp:Label ID="successLabel" runat="server" CssClass="text-success" Text="Your profile has been updated successfully"></asp:Label>
      </asp:Panel>
    </ContentTemplate>
    <Triggers>
      <asp:PostBackTrigger ControlID="btUpdate" />
    </Triggers>
  </asp:UpdatePanel>

  <div class="row">
    <div class="col-md-12">
      <h4>Change your account settings</h4>
      <hr />

      <div class="form-horizontal">
        <%--Profile--%>

        <div class="col-md-8">
          <%--First Name--%>
          <div class="form-group">
            <asp:Label ID="lbFirstName" runat="server" Text="First Name" CssClass="control-label col-md-1" AssociatedControlID="tbFirstName"></asp:Label>
            <div class="col-md-11">
              <asp:TextBox ID="tbFirstName" CssClass="form-control" runat="server"></asp:TextBox>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="tbFirstName" runat="server" ErrorMessage="First name cannot be more than 50 characters" ValidationExpression="^[\s\S]{0,50}$" Text="Maximum 50 characters for the first name" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
          </div>
          <%--Last Name--%>
          <div class="form-group">
            <asp:Label ID="lbLastName" runat="server" Text="Last Name" CssClass="control-label col-md-1" AssociatedControlID="tbLastName"></asp:Label>
            <div class="col-md-11">
              <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control"></asp:TextBox>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="tbLastName" runat="server" ErrorMessage="Last name cannot be more than 50 characters" ValidationExpression="^[\s\S]{0,100}$" Text="Maximum 50 characters for the last name" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
          </div>
          <%--Address--%>
          <div class="form-group">
            <asp:Label ID="lbAddress" runat="server" Text="Address" CssClass="control-label col-md-1" AssociatedControlID="tbAddress"></asp:Label>
            <div class="col-md-11">
              <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control"></asp:TextBox>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="tbAddress" runat="server" ErrorMessage="Address cannot be more than 250 characters" ValidationExpression="^[\s\S]{0,250}$" Text="Maximum 250 characters for the address" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
          </div>
          <%--Postcode--%>
          <div class="form-group">
            <asp:Label ID="lbPostcode" runat="server" Text="Postcode" CssClass="control-label col-md-1" AssociatedControlID="tbPostcode"></asp:Label>
            <div class="col-md-11">
              <asp:TextBox ID="tbPostcode" runat="server" CssClass="form-control"></asp:TextBox>
              <asp:RegularExpressionValidator ControlToValidate="tbPostcode" ErrorMessage="Postcode must be valid" Text="Postcode must be valid" ValidationExpression="(?:[A-Za-z]\d ?\d[A-Za-z]{2})|(?:[A-Za-z][A-Za-z\d]\d ?\d[A-Za-z]{2})|(?:[A-Za-z]{2}\d{2} ?\d[A-Za-z]{2})|(?:[A-Za-z]\d[A-Za-z] ?\d[A-Za-z]{2})|(?:[A-Za-z]{2}\d[A-Za-z] ?\d[A-Za-z]{2})" ID="RegularExpressionValidator1" runat="server" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
          </div>
          <%--Aboutme--%>
          <div class="form-group">
            <asp:Label ID="lbAboutMe" runat="server" Text="About Me" CssClass="control-label col-md-1" AssociatedControlID="tbAboutMe"></asp:Label>
            <div class="col-md-11">
              <asp:TextBox ID="tbAboutMe" TextMode="MultiLine" Rows="4" runat="server" CssClass="form-control"></asp:TextBox>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="tbAboutMe" runat="server" ErrorMessage="About me section cannot be more than 1000 characters" ValidationExpression="^[\s\S]{0,1000}$" Text="Maximum 1000 characters for the about me section" Display="Dynamic" CssClass="errorMessage" SetFocusOnError="true"></asp:RegularExpressionValidator>
            </div>
          </div>
          <%--password--%>
          <div class="form-group">
            <asp:Label ID="lbPassword" runat="server" Text="Password" CssClass="control-label col-md-1"></asp:Label>
            <div class="col-md-11">
              <asp:Button ID="btChangePassword" runat="server" Text="Change Password" CssClass="btn btn-default" PostBackUrl="ManagePassword.aspx" />
            </div>
          </div>
          <div class="col-md-offset-1">
            <asp:Button ID="btUpdate" runat="server" Text="Update Profile" CssClass="btn btn-success" OnClick="btUpdate_Click" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
          </div>
        </div>

        <%--image--%>
        <div class="col-md-4">
          <div class="thumbnail">
            <asp:Image ID="imgProfile" runat="server" />
          </div>
          <div class="form-group">
            <div class="col-md-12">
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
                      <input type="file" id="myFile" name="myFile">
                    </div>
                    <button type="button" class="btn btn-default fileinput-exists" data-dismiss="fileinput" title="remove">
                      Remove
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
            
        <br />
        
        <div class="row">
          <div class="col-md-12">
            <hr />
          </div>
          <div class="col-md-5 col-md-offset-1 ">
            <h5><b>My Favourite Walks: </b>
            <h5>
            <ul>
              <asp:Repeater ID="RepeaterFavouriteWalks" runat="server" ItemType="DogWalks.DAL.DogWalk">
                <ItemTemplate>
                  <li><a href='../Walks/WalkDetails?WalkID=<%#Item.WalkID %>'><%# Item.Title %></a></li>
                </ItemTemplate>
              </asp:Repeater>
            </ul>
            </h5>
          </div>

          <div class="col-md-5">
            <div class="col-md-offset-1 ">
              <h5>
                To see how a user views your profile, please
                    <asp:HyperLink ID="HyperLink1" runat="server">click here</asp:HyperLink>
              </h5>
            </div>
          </div>
        </div>








      </div>
    </div>
  </div>

</asp:Content>

<asp:Content ContentPlaceHolderID="CustomScriptContentChild" runat="server">
  <script>
    $(function () {
      $(document).on('change.bs.fileinput', '.fileinput', function (e) {
        var $this = $(this),
            $input = $this.find('input[type=file]'),
            $span = $this.find('.fileinput-filename');        
        if ($input[0].files !== undefined && $input[0].files.length == 1) {
          $span.removeClass('dropdown').html($.map($input[0].files, function (val) { return val.name; }));
        } 
      });
    });
  </script>
</asp:Content>
