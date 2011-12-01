class ProfessionsController < ApplicationController

  respond_to :html
  expose(:profession) { Profession.find(params[:id]) }
  expose(:recipe_groups) do
    groups = profession.recipe_groups.for_user(current_user)
    groups = groups.ordered_by_name
    groups = groups.include_recipes
    groups
  end

  # GET /professions/:id
  #
  # Shows the recipe information for the requested profession.
  def show
    respond_with(profession)
  end

end
