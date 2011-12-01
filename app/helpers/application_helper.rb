module ApplicationHelper

  # Returns the appropriate anchor identifier for the specified name.
  def anchor_identifier(name)
    "#{name.gsub(/\s+/, '_').downcase}-anchor"
  end

  # Returns the active navigation class name if the current controller matches
  # one of the controllers specified in the controller list.
  def active_class_if?(controller_list)

    # Make sure its an array.
    controller_list = [controller_list] unless controller_list.respond_to?(:to_a)

    controller_list.include?(controller.controller_name.to_sym) ? 'active' : nil
    
  end

end
