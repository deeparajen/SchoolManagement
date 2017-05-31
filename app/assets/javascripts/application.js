// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require dataTables/jquery.dataTables
//= require select2
//= require select2_locale_pt-BR
//= require turbolinks
//= require_tree .

//= require bootstrap-datepicker

// to handle modal box form validation
$(document).ajaxError(function(event,xhr,options,exc) {
    if (event) {
        event.preventDefault();
      }
    var errors = JSON.parse(xhr.responseText);
    var er ="<ul>";
    for(var i = 0; i < errors.length; i++){
        var list = errors[i];
        er += "<li>"+list+"</li>";
    }
    er+="</ul>";
    $("#error_explanation").html(er);
       
});