# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$(document).ready ->
  $('form#fx').on 'ajax:success', (event, data, status, xhr) ->
    $('input:text#result').val(data)
    return
  $('form#fx').on 'ajax:error', (event, xhr, status, error) ->
     $('input:text#result').val(error)
    return
  return

$ ->
  today = new Date
  today = new Date(today.getFullYear(), today.getMonth(), today.getDate())
  start = new Date(new Date(today).setDate(today.getDate() - 90))

  $('#dp1').fdatepicker
    startDate: start
    endDate: today
    format: 'dd-mm-yyyy'
    disableDblClickSelection: true
    leftArrow: '<<'
    rightArrow: '>>'
    closeIcon: 'X'
    closeButton: true
  return


