class TransformationsController < ApplicationController

  respond_to :html
  expose(:transformations) { current_user.transformations.ordered_by_name }
  expose(:transformation) { find_or_build_transformation }

  # GET /transformations
  #
  # Lists all transformations.
  def index
    respond_with(transformations)
  end

  # GET /transformations/new
  #
  # Displays the form to build a new transformation.
  def new
    respond_with(transformation)
  end

  # POST /transformations
  #
  # Creates a new transformation.
  def create
    flash[:notice] = 'The transformation was successfully added' if transformation.save
    respond_with(transformation, :location => transformations_path)
  end

  # GET /transformations/:id
  #
  # Displays the form to modify a transformation.
  def edit
    respond_with(transformation)
  end

  # PUT /transformations/:id
  #
  # Updates a transformation.
  def update
    flash[:notice] = 'The transformation was successfully modified' if transformation.update_attributes(params[:transformation])
    respond_with(transformation, :location => transformations_path)
  end

  # DELETE /transformations/:id
  #
  # Remove a transformation.
  def destroy
    begin
      transformation.destroy
      flash[:notice] = 'The transformation was successfully removed.'
    rescue ActiveRecord::DeleteRestrictionError
      flash[:notice] = 'The transformation could not be removed. reagents are still depending on it.'
    end
    redirect_to transformations_path
  end
  
  private

  # Find a transformation in the database, or build a new one if the id
  # request parameter is not present.
  def find_or_build_transformation
    params[:id].blank? ? current_user.transformations.new(params[:transformation]) : current_user.transformations.include_reagents.include_yields.find(params[:id])
  end

end
