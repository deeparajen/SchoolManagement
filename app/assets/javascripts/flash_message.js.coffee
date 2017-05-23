show_ajax_message = (msg, type) ->
  $("#flash-message").html "<div id='flash_#{type}'>#{msg}</div>"

$(document).ajaxComplete (event, request) ->
  msg = request.getResponseHeader("X-Flash-Messages")
  type = request.getResponseHeader("X-Message-Type")
  show_ajax_message msg, type #use whatever popup, notification or whatever plugin you want