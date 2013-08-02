class SessionsController < ApplicationController
  before_filter :require_no_admin, only: [:new, :create]

  def new
  end

  def create
    if password_match?(params[:password])
      session[:admin] = true
      redirect_to root_path, notice: "You are now logged in."
    else
      flash.now[:notice] = "Invalid password."
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You are now logged out."
  end

  private

  def password_match?(password)
    password == ENV['ADMIN_PASSWORD']
  end
end
