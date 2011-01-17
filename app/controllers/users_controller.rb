class UsersController < ApplicationController
  before_filter :require_user

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to root_path, :notice => "Your profile was updated."
    else
      render :edit
    end
  end
end
