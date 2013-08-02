require 'spec_helper'

describe SessionsController do
  render_views

  [:new, :create].each do |action|
    it "requires no admin for ##{action}" do
      allow(controller).to receive(:admin?).and_return(true)
      get action
      response.should redirect_to(root_path)
      flash[:notice].should include("already logged in")
    end
  end

  describe "#new" do
    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    context "with a valid password" do
      before do
        ENV['ADMIN_PASSWORD'] = 'password'
        post :create, password: 'password'
      end

      it "logs in as an admin" do
        controller.admin?.should == true
      end

      it "redirects to the root with a flash" do
        response.should redirect_to(root_path)
        flash[:notice].should include("logged in")
      end
    end

    context "with an invalid password" do
      it "renders the new template with a flash" do
        ENV['ADMIN_PASSWORD'] = 'password'
        post :create, password: 'foo'
        response.should render_template(:new)
        flash[:notice].should include("Invalid")
      end
    end
  end

  describe "#destroy" do
    before do
      session[:admin] == true
      delete :destroy
    end

    it "logs the user out" do
      controller.admin?.should == false
    end

    it "redirects to the root with a flash" do
      response.should redirect_to(root_path)
      flash[:notice].should include("logged out")
    end
  end
end
