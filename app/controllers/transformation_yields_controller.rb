class TransformationYieldsController < ApplicationController

  respond_to :js
  expose(:items) { Item.ordered_by_name }
  expose(:transformation_yield) { build_yield }

  # GET /transformation_yields/new
  #
  # Displays the form to add a new transformation yield.
  def new
    respond_with(transformation_yield)
  end

  # POST /transformation_yields
  #
  # Validates the transformation yield and adds it to the overlying
  # transformation.
  def create
    transformation_yield.valid?
    respond_with(transformation_yield)
  end
  
  private

  # Build a new transformation yield.
  def build_yield
    TransformationYield.new((params[:transformation_yield] || {}).merge(:transformation => Transformation.new))
  end
end
