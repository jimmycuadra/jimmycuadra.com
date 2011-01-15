class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    false
  end
  helper_method :current_user
end
