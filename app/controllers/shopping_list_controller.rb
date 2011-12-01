class ShoppingListController < ApplicationController

  respond_to :html
  expose(:reagent_groups) do
    groups = current_user.reagent_groups.ordered_by_name
    groups = groups.include_reagents
    groups
  end

  # GET /
  #
  # Displays the shopping list entries.
  def index
  end

end
