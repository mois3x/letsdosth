$(document).ready( function() {
  $('.advocate').click( function(event) {
    var form = $(this).closest('form').first();
    console.debug( form )
    var url = form.action;
    alert( url );
    event.preventDefault();
  });
});

