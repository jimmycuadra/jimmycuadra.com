require 'spec_helper'

describe User do
  it "requires a name" do
    user = User.new
    user.valid?
    user.should have(1).error_on(:name)
  end

  it "requires a valid URL" do
    user = User.new(:url => "foobar")
    user.valid?
    user.should have(1).error_on(:url)
  end

  it "doesn't allow mass assignment of avatar" do
    Factory(:user)
    expect {
      User.first.update_attributes!(:avatar => "hax0r3d")
    }.to_not change {
      User.first.avatar
    }
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

    it "populates the user's name" do
      @user.name.should == "Bongo"
    end

    it "populates the user's avatar" do
      @user.avatar.should == "http://i.imgur.com/asdf.jpg"
    end

    it "populates the user's URL" do
      @user.url.should == "http://bongo.com/"
    end
  end

  describe ".build_from_github" do
    let(:omniauth) do
      {
        "user_info" => {
          "email" => "bongo@example.com",
          "name" => "Bongo",
          "nickname" => "bongo",
          "urls" => {
            "Blog" => "http://example.com/",
            "GitHub" => "https://github.com/bongo"
          }
        }
      }
    end

    before(:each) do
      @user = User.build_from_github(omniauth)
    end

    it "populates the user's name" do
      @user.name.should == "Bongo"
    end

    it "populates the user's email" do
      @user.email.should == "bongo@example.com"
    end

    it "populates the user's URL" do
      @user.url.should == "http://example.com/"
    end
  end
end
