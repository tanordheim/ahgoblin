class AutoMailCharactersController < ApplicationController

  respond_to :html, :js
  expose(:characters) { current_user.auto_mail_characters.ordered_by_name.include_items }
  expose(:character) { find_or_build_character }

  # GET /auto_mail_characters
  #
  # Lists all available auto-mail characters.
  def index
    respond_with(characters)
  end

  # GET /auto_mail_characters/new
  #
  # Displays the form to add a new character.
  def new
    respond_with(character)
  end

  # POST /auto_mail_characters
  #
  # Creates the new auto mail character.
  def create
    flash[:notice] = 'The auto mail character was successfully added.' if character.save
    respond_with(character)
  end

  # GET /auto_mail_characters/:id/edit
  #
  # Displays the form to modify a character.
  def edit
    respond_with(character)
  end

  # PUT /auto_mail_characters/:id
  #
  # Updates an auto mail character.
  def update
    flash[:notice] = 'The auto mail character was successfully updated.' if character.update_attributes(params[:auto_mail_character])
    respond_with(character)
  end

  # DELETE /auto_mail_characters/:id
  #
  # Deletes an auto mail character.
  def destroy
    flash[:notice] = 'The auto mail character was successfully removed.'
    character.destroy
    respond_with(character)
  end

  private

  # Find a character by the id, or build a new one if the id attribute is not
  # present in the request.
  def find_or_build_character
    params[:id].blank? ? current_user.auto_mail_characters.build(params[:auto_mail_character]) : current_user.auto_mail_characters.find(params[:id])
  end

end
