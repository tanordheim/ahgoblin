class TransformationComponentsController < ApplicationController

  respond_to :js
  expose(:transformation_component) { build_component }
  expose(:transformations) { Transformation.ordered_by_name }
  expose(:item_id) { params[:item_id] }

  # GET /transformation_components/new
  #
  # Displays the form to add a new transformation component to a reagent.
  def new
    respond_with(transformation_component)
  end

  # POST /transformation_components
  #
  # Validates the transformation component and adds it to the overlying
  # reagent.
  def create
    transformation_component.valid?
    respond_with(transformation_component)
  end

  private

  # Build a new transformation component instance.
  def build_component
    TransformationComponent.new((params[:transformation_component] || {}).merge(:reagent => Reagent.new(:item_lookup_id => item_id)))
  end
  
end
