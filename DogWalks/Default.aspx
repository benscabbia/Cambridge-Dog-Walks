<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Frontend.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DogWalks.Default1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
  <link href="Content/defaultPageStyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <%--first section part 1--%>
  <div id="background" class="container-full-bg" style="background-image: url('http://i.imgur.com/ZmGZFcA.jpg'); -webkit-filter: brightness(70%);"></div>
  <div class="container special">
    <div class="row">
      <div class="Absolute-Center is-Responsive text-center">
        <h1 class="title-text">It's time for a walk.</h1>
        <h4 class=" text-white">Let us find you the perfect walk.</h4>
        <br />
        <a href="#middle" class="scroll btn btn-success btn-lg">Find a Walk</a>
      </div>
    </div>
  </div>

  <%--middle section part 2--%>
  <div id="middle" class="container">
    <h2>Let's find a great walk - TODO.</h2>
    <div class="row">
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#" />
          <div class="caption">
            <h3>Newest Walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#" />
          <div class="caption">
            <h3>Top Rated walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#" />
          <div class="caption">
            <h3>Longest Walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
    </div>

    <%--bottom section part 3--%>
    <div id="bottom" class="row">
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#"/>
          <div class="caption">
            <h3>Newest Walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#"/>
          <div class="caption">
            <h3>Top Rated walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
      <div class="col-sm-6 col-md-4">
        <div class="thumbnail">
          <img style="height: 200px; width: 100%; display: block;" src="#"/>
          <div class="caption">
            <h3>Longest Walks</h3>
            <p>ras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="CustomScriptContent" runat="server">
   <script  type="text/javascript">
     //smooth scrolling
     $(document).ready(function () {
       $(".scroll").click(function (event) {
         event.preventDefault();
         $('html,body').animate({ scrollTop: $(this.hash).offset().top - 30 }, 'slow');
       });
     });
</script>
 
</asp:Content>