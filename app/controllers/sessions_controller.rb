class SessionsController < ApplicationController
  def create
    return redirect_to :back, :notice => "You are already logged in." if current_user

    session[:return_to] = request.env["HTTP_REFERER"] || root_path
    redirect_to "/auth/#{params[:provider]}"
  end

  def destroy
    reset_session
    redirect_to :back, :notice => "You are now logged out."
  end
end
