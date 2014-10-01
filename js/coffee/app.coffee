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
    else
      $('.step_1').addClass('invalid_url')
  
  $('.links a').on 'click', (event) ->
    event.preventDefault()
    className = $(this).attr('href').replace('#', '')
    $('.step_2').removeClass('fb ig li tw').addClass(className)

fetchPhoto = ->
  $('body').addClass('loading')

  photoId = $('.photo_url').val().match(/photos\/(\d+)/)[1]

  _500px.api "/photos/#{photoId}", (response) ->
    $('body').removeClass('loading').addClass('step_2')
    if response.success
      $('.images').append($("<img class='photo' src='#{response.data.photo.image_url}' />"))
    else
      alert 'newp'

