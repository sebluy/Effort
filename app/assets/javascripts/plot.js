var ready = function() {
  $.plot($('#plot'), [ [[0,0], [1,1]] ], { yaxis: { max: 1 } }) ;
} ;

$(document).ready(ready) ;
$(document).on('page:load', ready) ;
