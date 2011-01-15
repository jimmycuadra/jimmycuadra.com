class User < ActiveRecord::Base
  validates_presence_of :username

  has_many :authentications
  has_many :comments
end
