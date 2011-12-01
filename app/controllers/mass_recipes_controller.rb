class MassRecipesController < ApplicationController

  respond_to :html
  expose(:recipe_groups) { current_user.recipe_groups.ordered_by_profession_name.ordered_by_name }
  expose(:mass_recipe) { MassRecipe.new(current_user, params[:mass_recipe]) }

  # GET /mass_recipes/new
  #
  # Displays the form to mass-add recipes.
  def new
    respond_with(mass_recipe)
  end

  # POST /mass_recipes
  #
  # Mass-creates all requested recipes.
  def create
    if mass_recipe.valid?
      flash[:notice] = "#{mass_recipe.item_id_collection.size} items were added"
      mass_recipe.create_recipes!
    end
    respond_with(mass_recipe, :location => profession_path(mass_recipe.recipe_group.profession))
  end

end
