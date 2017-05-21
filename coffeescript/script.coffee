$(document).ready ->
  $("#try-btn").click ->
    window.location.href = "#{encodeURIComponent $("#input").val()}?response=#{$('input[name=responseFormat]:checked').val()}"
