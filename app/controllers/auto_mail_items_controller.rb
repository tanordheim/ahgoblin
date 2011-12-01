class AutoMailItemsController < ApplicationController

  respond_to :js
  expose(:characters) { current_user.auto_mail_characters.ordered_by_name }
  expose(:item) { find_or_build_item }

  # GET /auto_mail_items/new
  #
  # Displays the form to add a new auto mail item.
  def new
    respond_with(item)
  end

  # POST /auto_mail_items
  #
  # Creates a new auto mail item.
  def create
    flash[:notice] = 'The item was successfully added.' if item.save
    respond_with(item)
  end

  # DELETE /auto_mail_items/:id
  #
  # Removes an auto mail item from the database.
  def destroy
    flash[:notice] = 'The item was successfully removed.'
    item.destroy
    respond_with(item)
  end

  private

  # Find an item by the id, or build a new one if the id attribute is not
  # present in the request.
  def find_or_build_item
    params[:id].blank? ? AutoMailItem.new(params[:auto_mail_item]) : AutoMailItem.for_user(current_user).find(params[:id])
  end
  
end
