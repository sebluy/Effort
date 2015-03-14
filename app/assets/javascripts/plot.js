var ready = function() {
  var plot_data = $('#plot_data').attr('value') ;
  if (plot_data.length) {
    var daily_data = $.parseJSON(plot_data) ;
    $.plot($('#daily_plot'), [daily_data]) ;

    var weekly_total_data = [] ;
    for (var i = -6 ; i <= 0 ; i++) {
      weekly_total = 0.0 ;
      for (var j = -6 ; j <= 0 ; j++) {
        weekly_total += daily_data[daily_data.length - 1 + i + j][1] ;
      }
      weekly_total_data.push([i, weekly_total]) ;
    }
    
    $.plot($('#weekly_total_plot'), [weekly_total_data]) ;
  }
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
