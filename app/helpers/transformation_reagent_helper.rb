module TransformationReagentHelper

  # Get an element identifier for the specified transformation reagent.
  def element_id_for_transformation_reagent(reagent)
    reagent.new_record? ? Time.now.to_f.to_s.gsub('.', '') : reagent.id
  end
  
end
