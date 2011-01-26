require 'spec_helper'

describe SessionsController do
  render_views

  describe "#new" do
    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "#create" do
    context "with a valid password" do
      before(:each) do
        controller.stub(:password_match?).and_return(true)
        post :create
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
        controller.stub(:password_match?).and_return(false)
        post :create
        response.should render_template(:new)
        flash[:notice].should include("Invalid")
      end
    end
  end
end
