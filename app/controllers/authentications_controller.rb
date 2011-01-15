class AuthenticationsController < ApplicationController
  def create
    omniauth = env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth["provider"], omniauth["uid"])
    if authentication
    else
      user = User.new
      user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
      user.save!
      session[:current_user] = user.id
      redirect_to root_path, :notice => "You are now signed in."
    end
  end
end
