class Comment < ActiveRecord::Base
  validates_presence_of :name, :email, :comment
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :allow_blank => true, :message => "must be a valid email address"
  validates_format_of :url, :with => /^(#{URI::regexp(%w(http https))})$/i, :allow_blank => true, :message => "must be valid URL"

  belongs_to :post

  before_validation :prepend_protocol

  private

  def prepend_protocol
    self.url = "http://#{url}" unless url =~ /^https?:\/\//
  end
end
