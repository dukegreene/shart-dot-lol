# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#shartener-form").on("ajax:success", (e, data, status, xhr) ->
    $form = $("#shartener-form")
    $form.toggle()
    $("#errors").remove()
    $("#inner-container").append xhr.responseText
  ).on("ajax:error", (e, xhr, status, error) ->
    console.log(xhr.responseText)
    $("#errors").remove()
    $("#error-catcher").append(xhr.responseText)
  )