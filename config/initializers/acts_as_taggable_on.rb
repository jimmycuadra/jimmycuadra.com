module ActsAsTaggableOn
  class Tag
    extend FriendlyId
    friendly_id :name, :use => :slugged

    self.remove_unused = true

    def normalize_friendly_id(text)
      super.gsub("_", "-")
    end
  end
end
