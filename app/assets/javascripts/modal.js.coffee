# Show the modal dialog.
$.showModal = (title, contents, options) ->

  options ||= {}
  isForm = if options.form? && options.form then true else false
  container = $('#modal-container')

  # Set the container title.
  $('h3', container).text(title)

  # Set the container body.
  $('.modal-body', container).html(contents)

  # Empty the modal footer.
  $('.modal-footer', container).empty()

  # Show the modal dialog.
  $('#modal-container').modal('show')

  if isForm

    # Add the submit and cancel buttons if this is a form.
    closeButton = $('<a href="#" class="btn secondary" data-close-modal="true">Cancel</a>')
    submitButton = $('<a href="#" class="btn primary" data-submit-modal-form="true">Submit</a>')
    $('.modal-footer', container).append(submitButton)
    $('.modal-footer', container).append(closeButton)

    # Focus the first field in the form.
    firstInput = $('div.input:first', $('.modal-body', container))
    if firstInput.length > 0
      $('select, input', firstInput).focus()

# Change the body of the current modal dialog.
$.setModalBody = (contents) ->

  container = $('#modal-container')
  $('.modal-body', container).html(contents)

# Close the modal dialog.
$.closeModal = ->
  
  container = $('#modal-container')
  container.modal('hide')

# Body onLoad event hook.
$ ->

  # Add hooks for the modal form close link.
  $('a[data-close-modal="true"]').live 'click', (e) ->
    e.preventDefault()
    $.closeModal()

  # Add hooks for the modal form submit link.
  $('a[data-submit-modal-form="true"]').live 'click', (e) ->
    e.preventDefault()
    form = $('#modal-container .modal-body form')
    form.submit()

  # Set up the modal dialog.
  $('#modal-container').modal(
    backdrop: true
    closeOnEscape: true
  )
