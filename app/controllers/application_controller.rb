class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  protected
  def logged_in?
    current_user != nil
  end

  def authorize
    unless logged_in?
      flash[:error] = 'Unauthorized access'
      redirect_to login_path
      false
    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
