class AuthenticationsController < ApplicationController
  def create
    omniauth = env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])

    if authentication
      session[:user_id] = authentication.user.id
      redirect_to (session[:return_to] || root_path), :notice => "Welcome back! You are now logged in."
      session[:return_to] = nil
    else
      user = case omniauth["provider"]
      when "twitter"
        User.build_from_twitter(omniauth)
      end

      if user.save
        session[:user_id] = user.id
        redirect_to (session[:return_to] || root_path), :notice => "You are now logged in."
        session[:return_to] = nil
      else
        redirect_to (session[:return_to] || root_path), :notice => "Validation failed."
        session[:return_to] = nil
      end
    end
  end
end
