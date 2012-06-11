#= require jquery_ujs

jQuery ->
  # Flash messages
  $("#flash").delay(1250).fadeOut("slow")

  # Comment previews
  $commentPreviewFrame = $("#comment-preview-frame")

  commentPreviewCallback = (html) ->
    $commentPreviewFrame.html(html)

  $("#preview-comment").on "click", (event) ->
    event.preventDefault()

    $form = $(event.currentTarget).closest("form")
    comment = $form.find("textarea").val()

    $.get "/comments/preview", { comment: comment }, commentPreviewCallback, "html"
