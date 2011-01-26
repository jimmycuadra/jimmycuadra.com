class Comment < ActiveRecord::Base
  validates_presence_of :name, :email, :comment
  validates_format_of :email, :with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, :allow_blank => true, :message => "must be a valid email address"

  belongs_to :post

  before_save :prepend_scheme, :unless => lambda { |record| record.url.blank? || record.url =~ /^https?:\/\// }

  private

  def prepend_scheme
    self.url = "http://#{url}"
  end
end
