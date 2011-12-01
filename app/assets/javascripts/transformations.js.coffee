$ ->

  # Handle remove link-clicks in the transformation reagent list.
  $('#transformation-reagents-container a[data-remove-reagent]').live 'click', (e) ->
    e.preventDefault()
    link = $(e.target)

    # Find the row for the reagent.
    row = link.closest('tr')
    fieldCell = link.closest('td')

    # If we have a hidden field with data-reagent-id defined, this is a
    # persisted record and must be removed with a destroy-field. If we can't
    # find the field, the reagent is not yet persisted and we can just remove
    # the whole row.
    idField = $('input[type="hidden"][data-reagent-id]', row)
    if idField.length == 0
      row.remove()
    else
      reagentId = idField.val()
      deleteField = $('<input type="hidden" name="transformation[reagents_attributes][' + reagentId + '][_destroy]" value="1" />')
      fieldCell.append(deleteField)
      row.hide()

  # Handle remove link-clicks in the transformation yield list.
  $('#transformation-yields-container a[data-remove-yield]').live 'click', (e) ->
    e.preventDefault()
    link = $(e.target)

    # Find the row for the yield.
    row = link.closest('tr')
    fieldCell = link.closest('td')

    # If we have a hidden field with data-yield-id defined, this is a
    # persisted record and must be removed with a destroy-field. If we can't
    # find the field, the yield is not yet persisted and we can just remove
    # the whole row.
    idField = $('input[type="hidden"][data-yield-id]', row)
    if idField.length == 0
      row.remove()
    else
      yieldId = idField.val()
      deleteField = $('<input type="hidden" name="transformation[yields_attributes][' + yieldId + '][_destroy]" value="1" />')
      fieldCell.append(deleteField)
      row.hide()
