class ItemComponentsController < ApplicationController

  respond_to :js
  expose(:item_component) { build_component }

  # GET /item_components/new
  #
  # Displays the form to add a new item component to a reagent.
  def new
    respond_with(item_component)
  end

  # POST /item_components
  #
  # Validates the item component and adds it to the overlying reagent.
  def create
    item_component.valid?
    respond_with(item_component)
  end

  private

  # Build a new item component instance.
  def build_component
    ItemComponent.new((params[:item_component] || {}).merge(:reagent => Reagent.new))
  end

end
