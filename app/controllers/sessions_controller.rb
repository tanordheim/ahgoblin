class SessionsController < ApplicationController

  skip_before_filter :require_authentication
  layout 'authentication'

  respond_to :html

  # GET /session/new
  #
  # Display the login form to the user.
  def new
  end

  # POST /session
  #
  # Attempt to authenticate the user.
  def create
    
    user = User.find_by_email(params[:email])
    Rails.logger.debug("Attempting to authenticate: #{user.inspect}")
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'You have been successfully logged in.'
    else
      render 'new'
    end

  end

  # DELETE /session
  #
  # Log out the user.
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
