# coding: utf-8
require 'spec_helper'

describe Post do
  before(:each) do
    @post = Factory.build(:post)
  end

  it "saves valid records" do
    @post.should be_valid
  end

  it "requires a title" do
    @post.title = nil
    @post.valid?
    @post.should have(1).error_on(:title)
  end

  it "requires a body" do
    @post.body = nil
    @post.valid?
    @post.should have(1).error_on(:body)
  end

  it "generates a slug when saved" do
    @post.save
    @post.cached_slug.should_not be_nil
  end

  it "approximates ASCII in generated slugs" do
    @post.title = "My résumé"
    @post.save
    @post.cached_slug.should == "my-resume"
  end

  it "converts underscores to dashes in generated slugs" do
    @post.title = "this_has_underscores"
    @post.save
    @post.cached_slug.should == "this-has-underscores"
  end

  context "with a video" do
    before(:each) do
      @post.youtube_id = "abc123"
    end

    context "with a title beginning with \"Screencast: \"" do
      before(:each) do
        @post.title = "Screencast: Awesome tutorial"
        @post.save
      end

      it "doesn't alter the title" do
        @post.title.should == "Screencast: Awesome tutorial"
      end

      it "doesn't alter the slug" do
        @post.cached_slug.should == "screencast-awesome-tutorial"
      end
    end

    context "with a title not beginning with \"Screencast: \"" do
      before(:each) do
        @post.title = "Awesome tutorial"
        @post.save
      end

      it "prepends the title with \"Screencast: \"" do
        @post.title.should == "Screencast: Awesome tutorial"
      end

      it "prepends the slug with \"screencast-\"" do
        @post.cached_slug.should == "screencast-awesome-tutorial"
      end
    end
  end

  describe "#screencast?" do
    it "returns true if the post has a youtube_id" do
      @post.youtube_id = "abc123"
      @post.should be_a_screencast
    end

    it "returns false if the post doesn't have a youtube_id" do
      @post.should_not be_a_screencast
    end
  end

  describe "with tags" do
    before(:each) do
      @post.tag_list = "ruby, to_lang, rails 3"
      @post.save
    end

    it "associates itself with the tags" do
      @post.tags.map(&:name).should == ["ruby", "to_lang", "rails 3"]
    end

    it "updates tag associations when updated" do
      @post.tag_list = "ruby, rails 3"
      @post.save
      @post.tags.map(&:name).should == ["ruby", "rails 3"]
    end

    it "destroys orphaned tags when the post is saved" do
      @post.tag_list = "ruby, rails 3"
      @post.save
      ActsAsTaggableOn::Tag.count.should == 2
    end

    it "destroys orphaned tags when the post is destroyed" do
      Factory.create(:post, :tag_list => "ruby")
      @post.destroy
      ActsAsTaggableOn::Tag.count.should == 1
    end

  end
end
