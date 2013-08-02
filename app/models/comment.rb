class Comment < ActiveRecord::Base
  validates_presence_of :name, :email, :comment
  validates_format_of :email, with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/, allow_blank: true, message: "must be a valid email address"

  belongs_to :post

  before_save :prepend_scheme, unless: lambda { |record| record.url.blank? || record.url =~ /^https?:\/\// }
  after_create lambda { |comment| Notification.new_comment(comment).deliver unless comment.email == ENV['ADMIN_EMAIL'] }

  def admin!
    self.name = "Jimmy Cuadra"
    self.email = "jimmy@jimmycuadra.com"
    self.url = "http://jimmycuadra.com/"
  end

  private

  def prepend_scheme
    self.url = "http://#{url}"
  end
end
