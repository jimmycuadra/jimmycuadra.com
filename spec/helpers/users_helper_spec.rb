require 'spec_helper'

describe UsersHelper do
  describe "#user_avatar" do
    it "uses the avatar attribute if available and email is not" do
      user = mock(User, :avatar => "/path/to/avatar", :email => nil, :name => "Bongo")
      user_avatar(user).should include("/path/to/avatar")
    end

    it "uses gravatar if email is available" do
      user = mock(User, :avatar => "/path/to/avatar", :email => "bongo@example.com", :name => "Bongo")
      user_avatar(user).should include(Digest::MD5.hexdigest(user.email.downcase))
    end

    it "uses the default gravatar if no avatar or email is available" do
      user = mock(User, :avatar => nil, :email => nil, :name => "Bongo")
      user_avatar(user).should include("http://www.gravatar.com/avatar/00000000000000000000000000000000?s=48")
    end
  end
end
