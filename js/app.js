(function() {
  $(document).ready(function() {
    $('.photo_url').bind('keyup', function() {
      if ($('.photo_url').val().length) {
        return $('.go').removeClass('hidden').addClass('animate_in');
      } else {
        return $('.go').addClass('hidden').removeClass('animate_in');
      }
    });
    $('.photo_url').on('paste', function() {
      return setTimeout((function() {
        var clean_str, str;
        str = $('.photo_url').val();
        clean_str = str.match(/^https:\/\/prime.500px.com\/photos\/\d+/)[0];
        return $('.photo_url').val(clean_str);
      }), 10);
    });
    $('.example').on('click', function() {
      $('.photo_url').val('https://prime.500px.com/photos/37790924');
      return $('.go').removeClass('hidden').addClass('animate_in');
    });
    return $('.go').on('click', function() {
      var str;
      str = $('.photo_url').val();
      if (str.match(/^https:\/\/prime.500px.com\/photos\/\d+/)) {
        return $('.step_1').addClass('animate_out');
      } else {
        return $('.step_1').addClass('invalid_url');
      }
    });
  });

}).call(this);
