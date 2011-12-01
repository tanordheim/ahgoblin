class RecipesController < ApplicationController

  respond_to :html, :js
  expose(:recipe_groups) do
    groups = current_user.recipe_groups
    groups = groups.ordered_by_profession_name.ordered_by_name
    groups = groups.include_recipes
    groups
  end
  expose(:recipe) { find_or_build_recipe }

  # GET /recipes/new
  #
  # Displays the form to build a new recipe.
  def new
    respond_with(recipe)
  end

  # POST /recipes
  #
  # Creates a new recipe.
  def create
    flash[:notice] = 'The recipe was successfully created.' if recipe.save
    respond_with(recipe, :location => profession_path(recipe.recipe_group.profession))
  end

  # GET /recipes/:id/edit
  #
  # Displays the form to edit a recipe.
  def edit
    respond_with(recipe)
  end

  # PUT /recipes/:id
  #
  # Updates a recipe.
  def update
    flash[:notice] = 'The recipe was successfully modified.' if recipe.update_attributes(params[:recipe])
    respond_with(recipe, :location => profession_path(recipe.recipe_group.profession))
  end

  # DELETE /recipes/:id
  #
  # Removes a recipe.
  def destroy
    begin
      recipe.destroy
      flash[:notice] = 'The recipe was successfully removed.'
    rescue ActiveRecord::DeleteRestrictionError
      flash[:notice] = 'The recipe could not be removed.'
    end
    respond_with(recipe, :location => profession_path(recipe.recipe_group.profession))
  end

  private

  # Find a recipe in the database, or build a new one if the id request
  # parameter is not present.
  def find_or_build_recipe
    params[:id].blank? ? Recipe.new(params[:recipe]) : Recipe.find(params[:id])
  end

end
