<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CarouselCodeBehindTest2.aspx.cs" Inherits="DogWalks.Demo.CarouselCodeBehindTest2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
  <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
  <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>

  <script type="text/javascript" src="../Scripts/jcarousellite_1.0.1.js"></script>
  <script type="text/javascript">
    $(function () {
      $(".anyClass").jCarouselLite({
        btnNext: ".next",
        btnPrev: ".prev"
      });
    });

  </script>

</head>
<body>
  <form id="form1" runat="server">
    <div>
      <div class="anyClass">
        <ul>
          <li>
            <img src=" sample-logo.png" alt="" width="100" height="100"></img></li>
          <li>
            <img src=" sample-logo.png" alt="" width="100" height="100"></img></li>
          <li>
            <img src=" sample-logo.png" alt="" width="100" height="100"></img></li>
          <li>
            <img src=" sample-logo.png" alt="" width="100" height="100"></img></li>
        </ul>
      </div>
      <button class="prev"><<</button>
      <button class="next">>></button>
    </div>
  </form>
</body>
</html>
