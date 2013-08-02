module ActsAsTaggableOn
  self.remove_unused_tags = true

  class Tag
    extend FriendlyId
    friendly_id :name, use: :slugged

    def normalize_friendly_id(text)
      super.gsub("_", "-")
    end
  end
end
