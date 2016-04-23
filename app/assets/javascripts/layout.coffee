jQuery(document).on "page:change", ->
  $('.side-menu-icon').click ->
    $('#sidebar ul').fadeToggle()
    
    