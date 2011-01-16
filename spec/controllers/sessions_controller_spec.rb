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
  end

  describe "#destroy" do
    before(:each) do
      session[:user_id] = 1
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
