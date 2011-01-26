class SessionsController < ApplicationController
  def new
  end

  def create
    if password_match?(params[:password])
      session[:admin] = true
      redirect_to root_path, :notice => "You are now logged in."
    else
      flash.now[:notice] = "Invalid password."
      render :new
    end
  end

  private

  def password_match?(password)
    password == ENV['ADMIN_PASSWORD']
  end
end
