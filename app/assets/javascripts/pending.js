/* this code is going to need some major refactoring after I learn
   the javascripts */
var timer ;
var ready = function() {
  clearInterval(timer) ;
  var server_time = $('#pending span#time').html() ;
  if (server_time != undefined) {
    var time = new Date('T' + server_time + 'Z') ;
    $('#pending span#time').html(display_string(time)) ;
    $('head title').html(display_string(time)) ;
    timer = setInterval(function() {myTimer(time)}, 1000) ;
  }
} ;

var display_string = function(time) {
  return time.toUTCString().substring(17, 25) ;
}

var myTimer = function(time) {
  time.setSeconds(time.getSeconds() + 1) ;
  $('#pending span#time').html(display_string(time)) ;
  $('head title').html(display_string(time)) ;
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
