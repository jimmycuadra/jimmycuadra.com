class Post < ActiveRecord::Base
  attr_accessible :title, :body, :youtube_id, :tag_list

  validates_presence_of :title, :body

  has_many :comments, :dependent => :destroy

  extend FriendlyId
  friendly_id :title, :use => :slugged
  acts_as_taggable_on :tags

  after_validation :enforce_screencast_title, :if => lambda { |record| record.screencast? }
  after_validation :enforce_screencast_tag, :if => lambda { |record| record.screencast? }
  after_save :destroy_orphaned_tags
  after_destroy :destroy_orphaned_tags

  def screencast?
    youtube_id.blank? ? false : true
  end

  def comments_allowed?
    self.created_at > 2.weeks.ago
  end

  def normalize_friendly_id(text)
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

  def destroy_orphaned_tags
    ActsAsTaggableOn::Tag.where("id NOT IN (SELECT tag_id FROM taggings)").destroy_all
  end
end
