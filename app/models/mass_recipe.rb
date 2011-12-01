# This is an model that supports mass-adding an artibary amount of recipes that
# all share the same reagent setup. Examples would be gems of any given type or
# glyphs.
class MassRecipe

  # Enable ActiveModel validations for this model.
  include ActiveModel::Validations

  # Define attributes.
  attr_accessor :item_ids, :recipe_group_id, :reagents_attributes

  # Validate that the recipe has a recipe group association.
  validates :recipe_group, :presence => true

  # Validate that the we have a list of item ids.
  validates :item_ids, :presence => true
  
  # Validate that the recipes has at least one reagent.
  validates :reagents, :presence => true

  # Initialize the mass recipe model.
  def initialize(current_user, attributes)

    @current_user = current_user

    # Assign attributes.
    attributes.each do |key, value|
      self.send(:"#{key}=", value)
    end

  end

  # Create a recipe for each of the item ids in the mass recipe.
  def create_recipes!

    recipes = []
    item_id_collection.each do |item_id|

      item = Item.find_or_load(item_id)
      recipe = Recipe.new(:item => item, :recipe_group => recipe_group)
      reagents.each do |reagent|
        recipe.reagents.build(:reagent => reagent.reagent, :quantity => reagent.quantity)
      end
      recipe.save!

      recipes << recipe

    end

  end

  # Returns the item IDS as an array.
  def item_id_collection
    item_ids.split(/\r?\n/)
  end

  # Return the recipe_group instance for our recipe_group_id.
  def recipe_group
    @recipe_group ||= current_user.recipe_groups.find(recipe_group_id)
  end

  # Returns the reagents for our reagent attributes.
  def reagents

    unless defined?(@reagents)

      @reagents = []
      (reagents_attributes || []).each do |reagent_attributes|

        reagent = Reagent.for_user(current_user).find(reagent_attributes[1][:reagent_id])
        @reagents << RecipeReagent.new(:recipe => Recipe.new, :reagent => reagent, :quantity => reagent_attributes[1][:quantity])

      end

    end
    @reagents

  end

  # to_key implementation to allow simple_form to work on this model. Just
  # returns nil, as this model will never be persisted.
  def to_key
    nil
  end

  # persisted? implementation to allow simple_form to work on this model. Just
  # returns false, as this model will never be persisted.
  def persisted?
    false
  end
  
  private

  # Returns the user that is mass-adding recipes.
  def current_user
    @current_user
  end

end
