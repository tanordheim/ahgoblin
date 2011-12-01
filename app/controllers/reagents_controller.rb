class ReagentsController < ApplicationController

  respond_to :html, :js
  expose(:reagent_groups) do
    groups = current_user.reagent_groups.ordered_by_name
    groups = groups.include_reagents
    groups
  end
  expose(:reagent) { find_or_build_reagent }

  # GET /reagents/new
  #
  # Displays the form to build a new reagent.
  def new
    respond_with(reagent)
  end

  # POST /reagents
  #
  # Creates a new reagent.
  def create
    flash[:notice] = 'The reagent was successfully created.' if reagent.save
    respond_with(reagent, :location => root_path)
  end

  # GET /reagents/:id/edit
  #
  # Displays the form to edit a reagent.
  def edit
    respond_with(reagent)
  end

  # PUT /reagents/:id
  #
  # Updates a reagent.
  def update
    flash[:notice] = 'The reagent was successfully modified.' if reagent.update_attributes(params[:reagent])
    respond_with(reagent, :location => root_path)
  end

  # DELETE /reagents/:id
  #
  # Remove a reagent.
  def destroy
    begin
      reagent.destroy
      flash[:notice] = 'The reagent was successfully removed.'
    rescue ActiveRecord::DeleteRestrictionError
      flash[:notice] = 'The reagent could not be removed, other reagents, recipes or transformations are depending on it.'
    end
    respond_with(reagent, :location => root_path)
  end

  private

  # Find a reagent in the database, or build a new one if the id request
  # parameter is not present.
  def find_or_build_reagent
    params[:id].blank? ? Reagent.new(params[:reagent]) : Reagent.for_user(current_user).include_components.find(params[:id])
  end
  
end
