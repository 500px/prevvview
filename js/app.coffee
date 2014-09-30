$('input.photo_url').on 'keypress', ->
  console.log('asdf')
  $(this).attr('size', $(this).val().length)
