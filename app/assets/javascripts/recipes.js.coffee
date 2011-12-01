$ ->

  # Handle remove link-clicks in the recipe reagent list.
  $('#reagents-container a[data-remove-recipe-reagent]').live 'click', (e) ->
    e.preventDefault()
    link = $(e.target)

    # Find the name of the model currently being administered.
    modelName = 'recipe'
    if $('#reagents-container[data-model-name]').length > 0
      modelName = $('#reagents-container').attr('data-model-name')

    # Find the row for the component.
    row = link.closest('tr')
    fieldCell = link.closest('td')

    # If we have a hidden field with data-recipe-reagent-id defined, this is a
    # persisted record and must be removed with a destroy-field. If we can't
    # find the field, the recipe reagent is not yet persisted and we can just
    # remove the whole row.
    idField = $('input[type="hidden"][data-recipe-reagent-id]', row)
    if idField.length == 0
      row.remove()
    else
      reagentId = idField.val()
      deleteField = $('<input type="hidden" name="' + modelName + '[reagents_attributes][' + reagentId + '][_destroy]" value="1" />')
      fieldCell.append(deleteField)
      row.hide()
