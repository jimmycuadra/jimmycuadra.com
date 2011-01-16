class SessionsController < ApplicationController
  def destroy
    reset_session
    redirect_to :back, :notice => "You are now logged out."
  end
end
