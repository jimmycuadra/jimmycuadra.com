//= require jquery_ujs

$(function () {
  var $commentPreviewFrame = $("#comment-preview-frame");

  $("#flash").delay(1250).fadeOut("slow");

  $("#preview-comment").on("click", function (event) {
    var $form = $(event.currentTarget).closest("form");

    event.preventDefault();

    $.get("/comments/preview", {
      comment: $form.find("textarea").val()
    }, function (html) {
      $commentPreviewFrame.html(html);
    }, "html");
  })
});
