function sign_out() {
  $("#login").show();
  $.get("log_in", {logout:"true"}, 
  function() {
    window.location="";
  })
}
