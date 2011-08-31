//= require jquery_ujs
//= require jquery.lifestream.min

$(function () {
  var user = "jimmycuadra";

  $("#lifestream").lifestream({
    limit: 5,
    list: [
      {
        service: "github",
        user: user
      },
      {
        service: "twitter",
        user: user
      },
    ],
    feedloaded: function () {
      setTimeout(function () {
        $("#lifestream-container").fadeIn();
      }, 1000);
    }
  });
});
