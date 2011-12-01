class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :require_authentication
  after_filter :flash_notice_to_headers_for_xhr

  expose(:professions) { Profession.ordered_by_name }

  private

  # Copy the flash notice to the HTTP headers for XHR requests.
  def flash_notice_to_headers_for_xhr
    return unless request.xhr?
    response.headers['X-Flash-Notice'] = flash[:notice] unless flash[:notice].blank?
    flash.discard
  end

  # Returns the currently authenticated user
  def current_user
    @current_user ||= User.where(:id => session[:user_id]).first if session[:user_id]
  end
  helper_method :current_user

  # Require that the user is authenticated.
  def require_authentication

    if current_user.blank?
      redirect_to new_session_path
      return false
    end

    true

  end

end
