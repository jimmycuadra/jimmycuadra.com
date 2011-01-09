class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  after_validation :enforce_screencast_title, :if => lambda { |record| record.screencast? }

  def screencast?
    video_url.blank? ? false : true
  end

  private

  def enforce_screencast_title
    self.title = "Screencast: #{title}" unless title.starts_with? "Screencast: "
  end
end
