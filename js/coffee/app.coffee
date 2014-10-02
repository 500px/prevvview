$(document).ready ->
  _500px.init(sdk_key: 'f5b30e8f2f455a41830df6010f4128c41b45c700')

  $('.photo_url').bind 'keyup', ->
    if $('.photo_url').val().length
      $('.go').removeClass('hidden').addClass('animate_in')
    else
      $('.go').addClass('hidden').removeClass('animate_in')

  $('.photo_url').on 'paste', ->
    setTimeout (->
      str = $('.photo_url').val()
      clean_str = str.match(/^https:\/\/prime.500px.com\/photos\/\d+/)[0]
      $('.photo_url').val(clean_str)
    ), 10

  $('.example').on 'click', ->
    $('.photo_url').val('https://prime.500px.com/photos/37790924').focus()
    $('.go').removeClass('hidden').addClass('animate_in')

  $('#url').on 'submit', (event) ->
    event.preventDefault()
    str = $('.photo_url').val()
    if str.match(/^https:\/\/prime.500px.com\/photos\/\d+/)
      $('.step_1').addClass('animate_out')
      fetchPhoto()
      setTimeout (->
        $('.step_1').addClass('hidden')
        setTimeout (->
          $('.step_2').removeClass('hidden').addClass('animate_in')
          $('.overlay').addClass('light')
          ), 400
      ), 400
    else
      $('.step_1').addClass('invalid_url')

  $('.links a').on 'click', (event) ->
    event.preventDefault()
    className = $(this).attr('href').replace('#', '')
    $('.step_2').removeClass('fb ig li tw').addClass(className)

  # $('body').mousemove (e) ->
  #   amountMovedX = (e.pageX * -1 / 100)
  #   amountMovedY = (e.pageY * -1 / 100)
  #   background_cap = 20
  #   phone_cap = 5
  #   if amountMovedX > background_cap
  #     amountMovedX = background_cap
  #   else if amountMovedX < -background_cap
  #     amountMovedX = -background_cap
  #   if amountMovedY > background_cap
  #     amountMovedY = background_cap
  #   else if amountMovedY < -background_cap
  #     amountMovedY = -background_cap
  #   $('.background').css({
  #     '-webkit-transform' : 'translateX(' + amountMovedX + 'px) translateY(' + amountMovedY + 'px)',
  #     '-moz-transform' : 'translateX(' + amountMovedX + 'px) translateY(' + amountMovedY + 'px)',
  #     '-ms-transform' : 'translateX(' + amountMovedX + 'px) translateY(' + amountMovedY + 'px)',
  #     '-o-transform' : 'translateX(' + amountMovedX + 'px) translateY(' + amountMovedY + 'px)',
  #     'transform' : 'translateX(' + amountMovedX + 'px) translateY(' + amountMovedY + 'px)',
  #   })
  #   if amountMovedX > phone_cap
  #     amountMovedX = phone_cap
  #   else if amountMovedX < -phone_cap
  #     amountMovedX = -phone_cap
  #   if amountMovedY > phone_cap
  #     amountMovedY = phone_cap
  #   else if amountMovedY < -phone_cap
  #     amountMovedY = -phone_cap
  #   $('.phone-hand').css({

  #     })


fetchPhoto = ->
  $('body').addClass('loading')

  photoId = $('.photo_url').val().match(/photos\/(\d+)/)[1]

  _500px.api "/photos/#{photoId}", (response) ->
    $('body').removeClass('loading')
    if response.success
      $('.prime-photo').css('background-image', "url(#{response.data.photo.image_url})")
      $('.prime-photo').addClass('fb')
    else
      alert 'Error'
