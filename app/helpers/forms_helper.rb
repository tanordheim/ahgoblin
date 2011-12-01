module FormsHelper

  # Render the error message block of a form.
  def render_form_errors(f)

    errors = ''

    if f.error_notification

      close_link = link_to('&times;'.html_safe, '#', :class => 'close')
      error_block = content_tag(:p, f.error_notification)
      errors = content_tag(:div, close_link + error_block, :class => 'alert-message warning fade in', :'data-alert' => 'alert')

    end

    errors

  end

end
