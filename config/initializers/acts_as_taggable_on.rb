module ActsAsTaggableOn
  class Tag
    has_friendly_id :name, :use_slug => true, :approximate_ascii => true

    def normalize_friendly_id(text)
      text.gsub!("_", "-")
      super
    end
  end
end
