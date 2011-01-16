class AuthenticationsController < ApplicationController
  def create
    omniauth = env["omniauth.auth"]

    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])

    if authentication
      session[:user_id] = authentication.user.id
      redirect_to root_path, :notice => "Welcome back! You are now logged in."
    else
      user = case omniauth["provider"]
      when "twitter"
        User.build_from_twitter(omniauth)
      end

      if user.save
        session[:user_id] = user.id
        redirect_to root_path, :notice => "You are now logged in."
      else
        redirect_to root_path, :notice => "Validation failed."
      end
    end
  end
end
