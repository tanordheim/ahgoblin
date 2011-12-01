class TransformationComponent < Component

  # Transformation components belong to transformations.
  belongs_to :transformation

  # Validate that the transformation component has a transformation
  # association.
  validates :transformation, :presence => true

  # Returns the production cost of the transformation component.
  def production_cost
    transformation.value_of_yielded_item(reagent.item) * quantity
  end
  
end
