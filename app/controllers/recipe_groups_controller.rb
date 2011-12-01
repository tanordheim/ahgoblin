class RecipeGroupsController < ApplicationController

  respond_to :html, :js
  expose(:professions) { Profession.ordered_by_name }
  expose(:profession) { load_requested_profession }
  expose(:recipe_groups) do
    if profession.blank?
      []
    else
      groups = profession.recipe_groups.for_user(current_user)
      groups = groups.ordered_by_name
      groups = groups.include_recipes
      groups
    end
  end
  expose(:recipe_group) { find_or_build_recipe_group }

  helper_method :original_profession_id

  # GET /recipe_groups/new
  #
  # Displays to the form to build a new recipe group.
  def new

    # If we have a profession ID set in the new action, put that in the
    # original profession id attribute.
    if !params[:recipe_group].blank? && !params[:recipe_group][:profession_id].blank?
      @original_profession_id = params[:recipe_group][:profession_id]
    end

    respond_with(recipe_group)

  end

  # POST /recipe_groups
  #
  # Creates a new recipe group.
  def create
    flash[:notice] = 'The recipe group was successfully created.' if recipe_group.save
    respond_with(recipe_group, :location => profession_path(profession))
  end

  # GET /recipe_groups/:id/edit
  #
  # Displays the form to edit a recipe group.
  def edit

    # Set the original profession ID attribute to match the profession id of
    # the recipe group.
    @original_profession_id = recipe_group.profession.id

    respond_with(recipe_group)

  end

  # PUT /recipe_groups/:id
  #
  # Updates a recipe group.
  def update
    flash[:notice] = 'The recipe group was successfully modified.' if recipe_group.update_attributes(params[:recipe_group])
    respond_with(recipe_group, :location => profession_path(profession))
  end

  # DELETE /recipe_groups/:id
  #
  # Remove a recipe group.
  def destroy

    # Set the original profession ID attribute to match the profession id of
    # the recipe group.
    @original_profession_id = recipe_group.profession.id

    begin
      recipe_group.destroy
      flash[:notice] = 'The recipe group was successfully removed.'
    rescue ActiveRecord::DeleteRestrictionError
      flash[:notice] = 'The recipe group could not be removed. Remove all recipes before removing the group.'
    end
    respond_with(recipe_group, :location => profession_path(recipe_group.profession))

  end

  private

  # Find a recipe group in the database, or build a new one if the id request
  # parameter is not present.
  def find_or_build_recipe_group
    params[:id].blank? ? current_user.recipe_groups.new(params[:recipe_group]) : current_user.recipe_groups.find(params[:id])
  end

  # Load the requested profession, if any.
  def load_requested_profession
    original_profession_id.blank? ? nil : professions.find(original_profession_id)
  end

  # Find the ID of the originally requested profession.
  def original_profession_id
    @original_profession_id ||= params[:original_profession_id]
  end
  
end
