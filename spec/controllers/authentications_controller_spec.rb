require 'spec_helper'

describe AuthenticationsController do
  describe "#create" do
    it_provides_authentication_with :twitter, {
      "provider" => "twitter",
      "uid" => "123",
      "user_info" => {
        "name" => "Bongo",
        "image" => "http://i.imgur.com/asdf.jpg",
        "urls" => {
          "Website" => "http://bongo.com/"
        }
      }
    }

    it_provides_authentication_with :github, {
      "provider" => "github",
      "uid" => "123",
      "user_info" => {
        "email" => "bongo@example.com",
        "name" => "Bongo",
        "urls" => {
          "Blog" => "http://example.com/",
        }
      }
    }
  end

  describe "#failure" do
    it "redirects back" do
      session[:return_to] = "http://dev.jimmycuadra.com/foobar"
      get :failure
      response.should redirect_to("http://dev.jimmycuadra.com/foobar")
    end

    it "sets the flash" do
      get :failure
      flash[:notice].should include("cancelled")
    end
  end
end
