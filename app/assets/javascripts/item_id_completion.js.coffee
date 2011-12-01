$ ->

  $('input[type="text"][data-item-id-completion]').live 'keyup.autocomplete', ->
    $(@).autocomplete(
      source: '/items'
      delay: 100
    )
