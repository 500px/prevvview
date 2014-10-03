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
      $('.step_1').addClass('animate_out').removeClass('animate_in')
      $('.buy .button').attr('href', str)
      fetchPhoto()
      setTimeout (->
        $('.step_1').addClass('hidden')
        setTimeout (->
          $('.step_2').removeClass('hidden').addClass('animate_in')
          $('.overlay').addClass('light')
          $('header').addClass('dark')
          $('body').on 'mousemove', parallaxMouseMove
          ), 400
      ), 400
      setTimeout (->
        $('.step_1, .step_2').removeClass('animate_out animate_in')
      ), 2000
    else
      $('.step_1').addClass('invalid_url')

  $('.links a').on 'click', (event) ->
    event.preventDefault()
    className = $(this).attr('href').replace('#', '')
    $('.step_2').removeClass('fb ig li tw').addClass(className)

  $('.back').on 'click', ->
    $('.step_2').addClass('animate_out')
    $('.overlay').removeClass('light')
    $('header').removeClass('dark')
    setTimeout (->
      $('.photo_url').val('')
      $('.go').addClass('hidden')
      $('.step_2').addClass('hidden')
      $('.step_1').removeClass('hidden').addClass('animate_in')
    ), 400
    setTimeout (->
      $('.step_2').removeClass('animate_out animate_in')
      $('.step_1').removeClass('invalid_url')
      $('body').off 'mousemove', parallaxMouseMove
    ), 400

  $background = $('.background')
  $foreground = $('.step_2')

  BACKGROUND_DEPTH = 20
  FOREGROUND_DEPTH = 10

  $window = $(window)

  windowWidth = windowHeight = 0

  windowResize = ->
    windowWidth = $window.width()
    windowHeight = $window.height()

  windowResize()

  $window.on 'resize', windowResize

  parallaxMouseMove = (e) ->
    x = e.pageX
    y = e.pageY

    x = -((x / windowWidth) - 0.5)
    y = -((y / windowHeight) - 0.5)

    $background.css
      transform: "translateX(#{Math.round(x * BACKGROUND_DEPTH)}px) translateY(#{Math.round(y * BACKGROUND_DEPTH)}px)"

    $foreground.css
      transform: "translateX(#{x * FOREGROUND_DEPTH}px) translateY(#{(y * FOREGROUND_DEPTH) + 10}px)"

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
