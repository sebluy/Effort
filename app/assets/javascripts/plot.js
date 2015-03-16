var ready = function() {
  var plot_data = $('#plot_data').attr('value') ;
  if (plot_data.length) {

    var summary = $.parseJSON(plot_data) ;

    var daily_data = [] ;
    var weekly_data = [] ;

    for (discipline in summary) {

      var discipline_daily_data = [] ;
      for (var i = summary[discipline].length - 1 ; i >= 0 ; i--) {
        discipline_daily_data.push([-i, summary[discipline][i]]) ;
      }
      daily_data.push(discipline_daily_data) ;

      var discipline_weekly_data = []
      for (var i = -6 ; i <= 0 ; i++) {
        var weekly_total = 0.0 ;
        for (var j = -6 ; j <= 0 ; j++) {
          weekly_total += discipline_daily_data
                            [discipline_daily_data.length - 1 + i + j][1] ;
        }
        discipline_weekly_data.push([i, weekly_total]) ;
      }
      weekly_data.push(discipline_weekly_data) ;
    }

    $.plot($('#daily_plot'), daily_data) ;
    $.plot($('#weekly_total_plot'), weekly_data) ;
  }
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
