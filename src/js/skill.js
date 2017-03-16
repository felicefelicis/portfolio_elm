/*fonction de codepen*/

$(document).ready(function () {
  $('.skill-icons').children('.active').each(function(i) {
    var row = $(this);
    setTimeout(function() {
      row.css('background','#f1c40f');
    }, 100*i);
  });
});