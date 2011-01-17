require 'spec_helper'

describe UsersController do
  describe "#edit" do
    it "redirects users who aren't logged in" do
      get :edit
      response.should redirect_to(root_path)
    end

    it "assigns the current user to @user" do
      log_in_as_user
      get :edit
      assigns(:user).should == controller.current_user
    end
  end
end
