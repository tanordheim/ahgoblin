class ReagentComponent < Component

  # Reagent components have an additional reference to references.
  belongs_to :reagent_reference, :class_name => 'Reagent', :foreign_key => 'reagent_reference_id'

  # Validate that the reagent component has an reagent reference association.
  validates :reagent_reference, :presence => true

  # Returns the production cost of the reagent reference component.
  def production_cost
    reagent_reference.production_cost * quantity
  end
  
end
