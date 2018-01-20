jQuery(document).on "page:change", ->
  $(".menu-content__listing-title").click ->
    $(".menu-content__listing-options").fadeToggle()

  $("body").click (event) ->
    if event.target.id != "m-c__listing-title"
      $(".menu-content__listing-options").fadeOut()