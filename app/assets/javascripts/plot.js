var ready = function() {
  var plot_data = $('#plot_data').attr('value') ;
  if (plot_data.length) {
    var json = $.parseJSON(plot_data) ;
    var data = [] ;
    for (var i = -6 ; i <= 0 ; i++) {
      data.push([i, json[i.toString()]]) ;
    }
    $.plot($('#plot'), [ data ]) ;
  }
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
