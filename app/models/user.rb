class User < ActiveRecord::Base
  validates_presence_of :name
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  attr_accessible :name, :email, :url

  has_many :authentications
  has_many :comments

  def self.build_from_twitter(omniauth)
    user = build_from_auth(omniauth)
    user.name = omniauth["user_info"]["name"] || omniauth["user_info"]["nickname"]
    user.avatar = omniauth["user_info"]["image"] if omniauth["user_info"]["image"]
    user.url = omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["urls"]["Twitter"] if omniauth["user_info"]["urls"]["Website"] || omniauth["user_info"]["urls"]["Twitter"]
    user
  end

  def self.build_from_github(omniauth)
    user = build_from_auth(omniauth)
    user.name = omniauth["user_info"]["name"] || omniauth["user_info"]["nickname"]
    user.email = omniauth["user_info"]["email"] if omniauth["user_info"]["email"]
    user.url = omniauth["user_info"]["urls"]["Blog"] || omniauth["user_info"]["urls"]["GitHub"] if omniauth["user_info"]["urls"]["Blog"] || omniauth["user_info"]["urls"]["GitHub"]
    user
  end

  private

  def self.build_from_auth(omniauth)
    user = User.new
    user.authentications.build(:provider => omniauth["provider"], :uid => omniauth["uid"])
    user
  end
end
