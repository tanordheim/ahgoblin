class RecipeReagentsController < ApplicationController

  respond_to :js
  expose(:reagents) { Reagent.for_user(current_user).ordered_by_name }
  expose(:recipe_reagent) { build_recipe_reagent }
  expose(:model_name) { params[:model_name] || 'recipe' }

  # GET /recipe_reagents/new
  #
  # Displays the form to add a new reagent to a recipe.
  def new
    respond_with(recipe_reagent)
  end

  # POST /recipe_reagents
  #
  # Validates the recipe reagent and adds it to the overlying recipe.
  def create
    recipe_reagent.valid?
    respond_with(recipe_reagent)
  end

  private

  # Build a new recipe reagent instance.
  def build_recipe_reagent
    RecipeReagent.new((params[:recipe_reagent] || {}).merge(:recipe => Recipe.new))
  end

end
