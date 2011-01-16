require 'spec_helper'

describe SessionsController do
  describe "#destroy" do
    before(:each) do
      session[:user_id] = 1
      request.env["HTTP_REFERER"] = "http://dev.jimmycuadra.com/"
    end

    it "destroys the session" do
      get 'destroy'
      session[:user_id].should_not be
    end

    it "redirects back to the previous page" do
      get 'destroy'
      response.should redirect_to(:back)
    end
  end
end
