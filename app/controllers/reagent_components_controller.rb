class ReagentComponentsController < ApplicationController

  respond_to :js
  expose(:reagent_component) { build_component }
  expose(:reagents) { Reagent.for_user(current_user).ordered_by_name }

  # GET /reagent_components/new
  #
  # Displays the form to add a new reagent component to a reagent.
  def new
    respond_with(reagent_component)
  end

  # POST /reagent_components
  #
  # Validates the reagent component and adds it to the overlying reagent.
  def create
    reagent_component.valid?
    respond_with(reagent_component)
  end

  private

  # Build a new reagent component instance.
  def build_component
    ReagentComponent.new((params[:reagent_component] || {}).merge(:reagent => Reagent.new))
  end
  
end
