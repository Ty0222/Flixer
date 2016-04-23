jQuery(document).on "page:change", ->
  $('.side-menu-icon').click (event) ->
    event.preventDefault()
    $('#sidebar ul').fadeToggle()