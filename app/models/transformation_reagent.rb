class TransformationReagent < ActiveRecord::Base


  # Transformation reagents belong to transformations.
  belongs_to :transformation

  # Transformation reagents belong to reagents.
  belongs_to :reagent

  # Validate that the transformation reagent is associated with a
  # transformation.
  validates :transformation, :presence => true

  # Validate that the transformation reagent is associated with a reagent.
  validates :reagent, :presence => true

end
