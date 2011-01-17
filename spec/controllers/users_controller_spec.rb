require 'spec_helper'

describe UsersController do
  describe "#edit" do
    it "redirects users who aren't logged in" do
      get :edit
      response.should redirect_to(root_path)
    end

    it "renders the edit template" do
      user = Factory(:user)
      log_in_as(user)
      get :edit
      response.should render_template(:edit)
    end
  end

  describe "#update" do
    before(:each) do
      user = Factory(:user)
      log_in_as(user)
    end

    it "redirects to root with flash on successful update" do
      put :update, :id => controller.current_user.id, :user => { :email => "bongo@example.com" }
      response.should redirect_to(root_path)
      flash[:notice].should include("profile was updated")
    end

    it "renders the edit template on failed update" do
      put :update, :id => controller.current_user.id, :user => { :name => nil }
      response.should render_template(:edit)
    end
  end
end
