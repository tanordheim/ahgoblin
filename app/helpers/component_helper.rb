module ComponentHelper

  # Get an element identifier for the specified component.
  def element_id_for_component(component)
    component.new_record? ? Time.now.to_f.to_s.gsub('.', '') : component.id
  end

end
