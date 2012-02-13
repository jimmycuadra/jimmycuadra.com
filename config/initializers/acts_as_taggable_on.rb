module ActsAsTaggableOn
  class Tag
    extend FriendlyId
    friendly_id :name, :use => [:slugged, :history]

    def normalize_friendly_id(text)
      text.gsub!("_", "-")
      super
    end
  end
end
