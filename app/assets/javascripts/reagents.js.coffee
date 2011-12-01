$.setItemReagentPriceFieldStatus = ->

  checkbox = $('input[type="checkbox"]#item_component_use_vendor_price')
  priceField = $('input[type="text"]#item_component_price_string')
  priceContainer = priceField.closest('div.string')

  if checkbox.is(':checked')
    priceContainer.hide()
  else
    priceContainer.show()

$.setTransformationComponentItemId = ->
  idLookupField = $('input[type="text"]#reagent_item_lookup_id')
  idValue = idLookupField.attr('value')

  targetField = $('input[type="hidden"]#transformation_component_item_id')
  targetField.val(idValue)

$ ->

  # Handle remove link-clicks in the reagent component list.
  $('#components-container a[data-remove-component]').live 'click', (e) ->
    e.preventDefault()
    link = $(e.target)

    # Find the row for the component.
    row = link.closest('tr')
    fieldCell = link.closest('td')

    # If we have a hidden field with data-component-id defined, this is a
    # persisted record and must be removed with a destroy-field. If we can't
    # find the field, the component is not yet persisted and we can just
    # remove the whole row.
    idField = $('input[type="hidden"][data-component-id][data-component-type]', row)
    if idField.length == 0
      row.remove()
    else
      componentId = idField.val()
      componentType = idField.attr('data-component-type')
      deleteField = $('<input type="hidden" name="reagent[' + componentType + '_components_attributes][' + componentId + '][_destroy]" value="1" />')
      fieldCell.append(deleteField)
      row.hide()

  # When the "use vendor price" checkbox is checked, hide the price field.
  $('input[type="checkbox"]#item_component_use_vendor_price').live 'change', (e) ->
    $.setItemReagentPriceFieldStatus()
