class ItemsController < ApplicationController

  respond_to :js
  expose(:items) { find_items }

  # GET /items
  #
  # Lists all available items, optionally filtering the list by the "term"
  # request parameter.
  def index
    respond_with(items)
  end

  private

  # Find the items, filtering them by the "term" request parameter.
  def find_items

    items = Item.ordered_by_name
    unless params[:term].blank?
      items = items.filter_by_term(params[:term])
    end

    items

  end

end
