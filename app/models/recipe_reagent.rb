class RecipeReagent < ActiveRecord::Base

  # Recipe reagents belongs to recipes.
  belongs_to :recipe

  # Recipe reagents are associated with a reagent.
  belongs_to :reagent

  # Validate that the recipe reagent has a recipe association.
  validates :recipe, :presence => true

  # Validate that the recipe reagent has a reagent association.
  validates :reagent, :presence => true

  # Calculate the production cost of the recipe reagent.
  def production_cost
    reagent.production_cost * quantity
  end

end
