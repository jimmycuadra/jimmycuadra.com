module ActsAsTaggableOn
  class Tag
    extend FriendlyId
    friendly_id :name, :use => :slugged

    def normalize_friendly_id(text)
      text.gsub!("_", "-")
      super
    end
  end
end
