# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#teachers').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    bFilter: false
    "ordering": false
    "bLengthChange": false
    "bAutoWidth": false
    "bStateSave": true
    sAjaxSource: $('#teachers').data('source')