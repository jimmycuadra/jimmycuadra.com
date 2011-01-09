class Post < ActiveRecord::Base
  validates_presence_of :title, :body
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true

  def screencast?
    video_url.blank? ? false : true
  end
end
