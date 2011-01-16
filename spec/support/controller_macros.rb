module ControllerMacros
  def log_in_as_user
    controller.stub(:current_user).and_return(mock(User, :id => 2, :username => "Bongo"))
    session[:user_id] = current_user.id
  end

  def log_in_as_admin
    controller.stub(:current_user).and_return(mock(User, :id => 1, :username => "Jimmy"))
    session[:user_id] = current_user.id
  end
end
