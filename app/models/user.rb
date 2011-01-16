class User < ActiveRecord::Base
  validates_presence_of :username

  has_many :authentications
  has_many :comments

  def self.build_from_twitter(omniauth)
    user = build_from_auth(omniauth)
    user.username = omniauth["user_info"]["name"] || omniauth["user_info"]["nickname"]
    user.avatar = omniauth["user_info"]["image"] if omniauth["user_info"]["image"]
    user.url = omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["urls"]["Twitter"] if omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["urls"]["Twitter"]
    user
  end

  private

  def self.build_from_auth(omniauth)
    user = User.new
    user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
    user
  end
end
