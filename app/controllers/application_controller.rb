class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :admin?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def admin?
    current_user && current_user.id == 1
  end

  private

  def require_user
    redirect_to root_path, :notice => "You must be logged in." unless current_user
  end
end
