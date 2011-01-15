class AuthenticationsController < ApplicationController
  def create
    omniauth = env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])
    if authentication
      session[:current_user] = authentication.user.id
      redirect_to root_path, :notice => "Welcome back! You are now signed in."
    elsif current_user
      redirect_to root_path, :notice => "Adding another authorization is NYI."
    else
      user = User.new
      user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
      user.username = omniauth["user_info"]["name"] || omniauth["user_info"]["nickname"]
      user.avatar = omniauth["user_info"]["image"] if omniauth["user_info"]["image"]
      user.url = omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["Twitter"] if omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["Twitter"]
      if user.save
        session[:current_user] = user.id
        redirect_to root_path, :notice => "You are now signed in."
      else
        redirect_to root_path, :notice => "Validation failed."
      end
    end
  end
end
