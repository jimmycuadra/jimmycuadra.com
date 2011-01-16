require 'spec_helper'

describe AuthenticationsController do
  describe "#create" do
    let(:omniauth) do
      {
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
    end

    before(:each) do
      request.env["omniauth.auth"] = omniauth
    end

    it "logs the user in by putting their ID in the session" do
      post :create, :provider => "twitter"
      session[:user_id].should == User.first.id
    end

    it "redirects the user back" do
      session[:return_to] = "http://dev.jimmycuadra.com/foobar"
      post :create, :provider => "twitter"
      response.should redirect_to("http://dev.jimmycuadra.com/foobar")
    end

    context "when the authentication doesn't exist yet" do
      it "creates a new user" do
        expect {
          post :create, :provider => "twitter"
        }.to change {
          User.count
        }.from(0).to(1)
      end
    end

    context "when the authentication exists" do
      it "does not create a new user" do
        User.build_from_twitter(omniauth).save!

        expect {
          post :create, :provider => "twitter"
        }.to_not change {
          User.count
        }
      end
    end
  end
end
