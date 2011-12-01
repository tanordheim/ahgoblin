class ReagentGroupsController < ApplicationController

  respond_to :js
  expose(:reagent_groups) do
    groups = current_user.reagent_groups.ordered_by_name
    groups = groups.include_reagents
    groups
  end
  expose(:reagent_group) { find_or_build_reagent_group }

  # GET /reagent_groups/new
  #
  # Displays the form to build a new reagent group.
  def new
    respond_with(reagent_group)
  end

  # POST /reagent_groups
  #
  # Creates a new reagent group.
  def create
    flash[:notice] = 'The reagent group was successfully created.' if reagent_group.save
    respond_with(reagent_group)
  end

  # GET /reagent_groups/:id/edit
  #
  # Displays the form to edit a reagent group.
  def edit
    respond_with(reagent_group)
  end

  # PUT /reagent_groups/:id
  #
  # Updates a reagent group.
  def update
    flash[:notice] = 'The reagent group was successfully modified.' if reagent_group.update_attributes(params[:reagent_group])
    respond_with(reagent_group)
  end

  # DELETE /reagent_groups/:id
  #
  # Remove a reagent group.
  def destroy
    begin
      reagent_group.destroy
      flash[:notice] = 'The reagent group was successfully removed.'
    rescue ActiveRecord::DeleteRestrictionError
      flash[:notice] = 'The reagent group could not be removed. Remove all reagents before removing the group.'
    end
    respond_with(reagent_group)
  end
  
  private

  # Find a reagent group in the database, or build a new one if the id request
  # parameter is not present.
  def find_or_build_reagent_group
    params[:id].blank? ? current_user.reagent_groups.build(params[:reagent_group]) : current_user.reagent_groups.find(params[:id])
  end

end
