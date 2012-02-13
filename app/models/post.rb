class Post < ActiveRecord::Base
  attr_accessible :title, :body, :youtube_id, :tag_list

  validates_presence_of :title, :body

  has_many :comments, :dependent => :destroy

  extend FriendlyId
  friendly_id :title, :use => :slugged
  acts_as_taggable

  after_validation :enforce_screencast_title, :if => lambda { |record| record.screencast? }
  after_validation :enforce_screencast_tag, :if => lambda { |record| record.screencast? }

  def screencast?
    youtube_id.blank? ? false : true
  end

  def comments_allowed?
    self.created_at > 2.weeks.ago
  end

  def normalize_friendly_id(text)
    text = "Screencast: #{text}" if screencast? && !title.starts_with?("Screencast: ")
    text.gsub!("_", "-")
    super
  end

  private

  def enforce_screencast_title
    self.title = "Screencast: #{title}" unless title.starts_with? "Screencast: "
  end

  def enforce_screencast_tag
    self.tag_list << "screencast" unless self.tag_list.include? "screencast"
  end
end
