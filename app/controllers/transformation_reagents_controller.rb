class TransformationReagentsController < ApplicationController

  respond_to :js
  expose(:reagents) { Reagent.for_user(current_user).ordered_by_name }
  expose(:transformation_reagent) { build_reagent }

  # GET /transformation_reagents/new
  #
  # Displays the form to add a new transformation reagent.
  def new
    respond_with(transformation_reagent)
  end

  # POST /transformation_reagents
  #
  # Validates the transformation reagent and adds it to the overlying
  # transformation.
  def create
    transformation_reagent.valid?
    respond_with(transformation_reagent)
  end

  private

  # Build a new transformation reagent.
  def build_reagent
    TransformationReagent.new((params[:transformation_reagent] || {}).merge(:transformation => Transformation.new))
  end
  
end
