class Component < ActiveRecord::Base

  # Components belongs to reagents.
  belongs_to :reagent

  # Validate that the component has a reagent association.
  validates :reagent, :presence => true

end
