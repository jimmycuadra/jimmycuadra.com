require 'spec_helper'

describe User do
  it "requires a username" do
    user = User.new
    user.valid?
    user.should have(1).error_on(:username)
  end

  describe ".build_from_twitter" do
    let(:omniauth) do
      {
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
      @user = User.build_from_twitter(omniauth)
    end

    it "populates the user's username" do
      @user.username.should == "Bongo"
    end

    it "populates the user's avatar" do
      @user.avatar.should == "http://i.imgur.com/asdf.jpg"
    end

    it "populates the user's URL" do
      @user.url.should == "http://bongo.com/"
    end
  end
end
