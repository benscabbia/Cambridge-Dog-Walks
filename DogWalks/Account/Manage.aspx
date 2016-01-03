<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/MasterPages/FrontendChild.master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="DogWalks.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="HeadContentChild" runat="server">
  <script src="../Scripts/jasny-bootstrap.js"></script>
  <link href="../Content/jasny-bootstrap.min.css" rel="stylesheet" />

  <style>
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
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContentChild" runat="server">
  <h2><%: Title %>.</h2>

  <div>
    <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
      <p class="text-success"><%: SuccessMessage %></p>
    </asp:PlaceHolder>
  </div>

  <div class="row">
    <div class="col-md-12">
      <div class="form-horizontal">
        <h4>Change your account settings</h4>
        <hr />

        <div class="form-horizontal">
          <%--Profile--%>

          <div class="col-md-8">
            <%--First Name--%>
            <div class="form-group">
              <asp:Label ID="lbFirstName" runat="server" Text="First Name" CssClass="control-label col-md-1"></asp:Label>
              <div class="col-md-11">
                <asp:TextBox ID="tbFirstName" CssClass="form-control" runat="server"></asp:TextBox>
              </div>
            </div>
            <%--Last Name--%>
            <div class="form-group">
              <asp:Label ID="lbLastName" runat="server" Text="Last Name" CssClass="control-label col-md-1 "></asp:Label>
              <div class="col-md-11">
                <asp:TextBox ID="tbLastName" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <%--Address--%>
            <div class="form-group">
              <asp:Label ID="lbAddress" runat="server" Text="Address" CssClass="control-label col-md-1"></asp:Label>
              <div class="col-md-11">
                <asp:TextBox ID="tbAddress" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <%--Postcode--%>
            <div class="form-group">
              <asp:Label ID="lbPostcode" runat="server" Text="Postcode" CssClass="control-label col-md-1 "></asp:Label>
              <div class="col-md-11">
                <asp:TextBox ID="tbPostcode" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
            <%--Aboutme--%>
            <div class="form-group">
              <asp:Label ID="Label1" runat="server" Text="About Me" CssClass="control-label col-md-1 "></asp:Label>
              <div class="col-md-11">
                <asp:TextBox ID="tbAboutMe" TextMode="MultiLine" Rows="4" runat="server" CssClass="form-control"></asp:TextBox>
              </div>
            </div>
          </div>

          <div class="col-md-4">
            <div class="form-group">
              <%--<asp:Label ID="lbImage" runat="server" Text="Image" CssClass="control-label col-md-1"></asp:Label>
              <div class="col-md-11">--%>
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
          </div>

          </div>
        </div>
      </div>
    </div>
  
  <%--#### next section ####--%>
  <div class="row">
    <div class="col-md-12">
      <dl class="dl-horizontal">
        <dt>Password:</dt>
        <dd>
          <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
          <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
        </dd>
        <%--<dt>External Logins:</dt>
                    <dd><%: LoginsCount %>
                        <asp:HyperLink NavigateUrl="/Account/ManageLogins" Text="[Manage]" runat="server" />

                    </dd>--%>
        <%--
                        Phone Numbers can used as a second factor of verification in a two-factor authentication system.
                        See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                        for details on setting up this ASP.NET application to support two-factor authentication using SMS.
                        Uncomment the following blocks after you have set up two-factor authentication
        --%>
        <%--
                    <dt>Phone Number:</dt>
                    <% if (HasPhoneNumber)
                       { %>
                    <dd>
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Add]" />
                    </dd>
                    <% }
                       else
                       { %>
                    <dd>
                        <asp:Label Text="" ID="PhoneNumber" runat="server" />
                        <asp:HyperLink NavigateUrl="/Account/AddPhoneNumber" runat="server" Text="[Change]" /> &nbsp;|&nbsp;
                        <asp:LinkButton Text="[Remove]" OnClick="RemovePhone_Click" runat="server" />
                    </dd>
                    <% } %>
        --%>

        <%-- <dt>Two-Factor Authentication:</dt>
                    <dd>--%>
        <%--<p>
                            There are no two-factor authentication providers configured. See <a href="http://go.microsoft.com/fwlink/?LinkId=403804">this article</a>
                            for details on setting up this ASP.NET application to support two-factor authentication.
                        </p>--%>
        <% if (TwoFactorEnabled)
           { %>
        <%--
                        Enabled
                        <asp:LinkButton Text="[Disable]" runat="server" CommandArgument="false" OnClick="TwoFactorDisable_Click" />
        --%>
        <% }
           else
           { %>
        <%--
                        Disabled
                        <asp:LinkButton Text="[Enable]" CommandArgument="true" OnClick="TwoFactorEnable_Click" runat="server" />
        --%>
        <% } %>
        <%--</dd>--%>
      </dl>

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
