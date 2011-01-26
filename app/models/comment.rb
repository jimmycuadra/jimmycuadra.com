class Comment < ActiveRecord::Base
  validates_presence_of :name, :email, :comment
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :allow_blank => true
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/i, :allow_blank => true

  belongs_to :post
end
