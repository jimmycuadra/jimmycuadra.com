class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?

  def admin?
    session[:admin] == true
  end

  private

  def require_admin
    redirect_to root_path, :notice => "You are not authorized." unless admin?
  end
end
