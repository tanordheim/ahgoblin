module TransformationYieldHelper

  # Get an element identifier for the specified transformation yield.
  def element_id_for_transformation_yield(transformation_yield)
    transformation_yield.new_record? ? Time.now.to_f.to_s.gsub('.', '') : transformation_yield.id
  end
  
end
