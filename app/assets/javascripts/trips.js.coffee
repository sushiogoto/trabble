# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.vote')
  .on('ajax:send', -> $(this).addClass('loading'))
  .on('ajax:complete', -> $(this).removeClass('loading'))
  .on('ajax:error', -> $(this).after('<div class="error">There was an issue.</div>'))
  .on('ajax:success', (data) -> $(this).html(data.count))