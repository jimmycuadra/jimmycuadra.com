class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?

  def admin?
    session[:admin] == true
  end

  private

  def require_admin
    redirect_to root_path, :notice => "You are not authorized." unless admin?
  end

  def require_no_admin
    redirect_to root_path, :notice => "You are already logged in." if admin?
  end
end
