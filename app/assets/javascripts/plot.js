var ready = function() {
  var plot_data = $('#plot_data').attr('value') ;
  if (plot_data.length) {
    var summary = $.parseJSON(plot_data) ;

    var daily_data = [] ;
    var weekly_data = [] ;

    for (discipline in summary) {
      values = summary[discipline] ;

      discipline_daily_data = extract_discipline_daily(values) ;
      daily_data.push(
          { label: discipline, data: discipline_daily_data }
      ) ;

      discipline_weekly_data = moving_weekly_sums(values) ;
      weekly_data.push(
          { label: discipline, data: discipline_weekly_data }
      ) ;
    }

    var options = {
      legend: {
        show: true,
        position: 'nw'
      }
    }

    $('#daily_plot').plot(daily_data, options) ;
    $('#weekly_total_plot').plot(weekly_data, options) ;
  }
} ;

var extract_discipline_daily = function(daily_values) {
  var points = [] ;
  for (var i = daily_values.length - 1 ; i >= 0 ; i--) {
    points.push([-i, daily_values[i]]) ;
  }
  return points ;
}

var moving_weekly_sums = function(daily_values) {
  var sums = [] ;

  var total = weekly_sum(daily_values) ;
  sums.push([0, total]) ;
  
  /* use difference equation */
  for (var i = 1 ; i < 7 ; i++) {
    total -= daily_values[i - 1] ;
    total += daily_values[i + 6] ;
    sums.push([-i, total]) ;
  }

  return sums ;
}

var weekly_sum = function(week) {
  sum = 0.0 ;
  for (var i = 0 ; i < 7 ; i++) {
    sum += week[i] ;
  }
  return sum ;
}
 
$(document).ready(ready) ;
$(document).on('page:load', ready) ;
