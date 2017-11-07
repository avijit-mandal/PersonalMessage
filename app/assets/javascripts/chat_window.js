$(function(){
  $(".user-names").click(function () {
    $(document.getElementById('sidebar_secondary').innerHTML).clone();
  });
})