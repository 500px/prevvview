(function() {
  $('input.photo_url').on('keypress', function() {
    console.log('asdf');
    return $(this).attr('size', $(this).val().length);
  });

}).call(this);
