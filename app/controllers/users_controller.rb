class UsersController < ApplicationController
  before_filter :require_user

  def edit
    @user = current_user
  end
end
