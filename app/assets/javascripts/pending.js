/* this code is going to need some major refactoring after I learn
   the javascripts */
var timer ;
var ready = function() {
  clearInterval(timer) ;
  var server_time = $('#time').html() ;
  if (server_time != undefined) {
    var server_times = server_time.split(':').map(function(str) {
                                return parseInt(str) ; }) ;
    var time = new Date() ;
    time.setSeconds(server_times[2]) ;
    time.setMinutes(server_times[1]) ;
    time.setHours(server_times[0]) ;
    $('#time').html(display_string(time)) ;
    $('head title').html(display_string(time)) ;
    timer = setInterval(function() {myTimer(time)}, 1000) ;
  }
} ;

var display_string = function(time) {
  return time.toString().substring(16, 24) ;
}

var myTimer = function(time) {
  time.setSeconds(time.getSeconds() + 1) ;
  $('#time').html(display_string(time)) ;
  $('head title').html(display_string(time)) ;
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
