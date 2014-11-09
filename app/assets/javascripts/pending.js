var timer ;
var ready = function() {
  var date = new Date(0) ;
  clearInterval(timer) ;
  $('#pending span#time').html(date.toUTCString().substring(17, 25)) ;
  timer = setInterval(function() {myTimer(date)}, 1000) ;
} ;

var myTimer = function(date) {
  date.setSeconds(date.getSeconds() + 1) ;
  $('#pending span#time').html(date.toUTCString().substring(17, 25)) ;
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
