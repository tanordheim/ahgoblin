$.showFlashMessage = (message) ->

  noticeContainer = $('#notice-container')

  container = $('<div class="alert-message info" data-alert="true" />')
  closeLink = $('<a href="#" class="close">&times;</a>')

  messageContainer = $('<p/>')
  messageContainer.text(message)

  container.append(closeLink)
  container.append(messageContainer)

  # Remove any pre-existing notices.
  noticeContainer.empty()

  # Add the new message.
  noticeContainer.append(container)

$ ->

  noticeContainer = $('#notice-container')

  # If we have a content div within the container, move the notice container
  # there.
  contentContainer = $('.container-fluid > .content')
  if contentContainer.length > 0

    # If we have a page-header div within the content block, move the notice
    # below that. Otherwise, put it first within the content div.
    pageHeader = $('> .page-header:first', contentContainer)
    if pageHeader.length > 0
      pageHeader.after(noticeContainer.remove())
    else
      contentContainer.prepend(noticeContainer.remove())

  # Upon completing ajax requests, handle any flash notices defined in the
  # response headers.
  $(document).ajaxComplete (e, request, opts) ->
    notice = request.getResponseHeader('X-Flash-Notice')
    if notice?
      $.showFlashMessage(notice)
