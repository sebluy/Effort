/* this code is going to need some major refactoring after I learn
   the javascripts */
var timer ;
var ready = function() {
  var date = new Date(0) ;
  clearInterval(timer) ;
  if ($('#pending span#time').html() != undefined) {
    $('#pending span#time').html(date.toUTCString().substring(17, 25)) ;
    $('head title').html(date.toUTCString().substring(17, 25)) ;
    timer = setInterval(function() {myTimer(date)}, 1000) ;
  }
} ;

var myTimer = function(date) {
  date.setSeconds(date.getSeconds() + 1) ;
  $('#pending span#time').html(date.toUTCString().substring(17, 25)) ;
  $('head title').html(date.toUTCString().substring(17, 25)) ;
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
