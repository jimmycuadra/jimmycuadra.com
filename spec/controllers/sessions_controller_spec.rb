require 'spec_helper'

describe SessionsController do
  describe "#create" do
    before(:each) do
      request.env["HTTP_REFERER"] = "http://dev.jimmycuadra.com/foobar"
    end

    it "stores the referring URL" do
      get :create, :provider => "twitter"
      session[:return_to].should == "http://dev.jimmycuadra.com/foobar"
    end

    it "redirects to the omniauth path" do
      get :create, :provider => "twitter"
      response.should redirect_to('/auth/twitter')
    end

    it "redirects back if the user is already logged in" do
      controller.stub(:current_user).and_return(true)
      get :create, :provider => "twitter"
      response.should redirect_to(:back)
    end
  end

  describe "#destroy" do
    it "redirects users who are not logged in" do
      get :destroy
      response.should redirect_to(root_path)
      flash[:notice].should include("must be logged in")
    end

    context "when the user is logged in" do
      before(:each) do
        log_in_as_user
        request.env["HTTP_REFERER"] = "http://dev.jimmycuadra.com/foobar"
      end

      it "destroys the session" do
        get :destroy
        session[:user_id].should_not be
      end

      it "redirects back" do
        get :destroy
        response.should redirect_to(:back)
      end
    end
  end
end
