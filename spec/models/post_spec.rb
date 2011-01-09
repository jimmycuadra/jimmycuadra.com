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

  context "with a video" do
    before(:each) do
      @post.video_url = "path/to/a/video"
    end

    it "prepends the title with \"Screencast: \"" do
      @post.title = "Awesome tutorial"
      @post.save
      @post.title.should == "Screencast: Awesome tutorial"
    end

    it "doesn't alter the title if it's already prefixed with \"Screencast: \"" do
      @post.title = "Screencast: Awesome tutorial"
      @post.save
      @post.title.should == "Screencast: Awesome tutorial"
    end

    it "prepends the slug with \"screencast-\"" do
      @post.title = "Awesome tutorial"
      @post.save
      @post.cached_slug.should == "screencast-awesome-tutorial"
    end

    it "doesn't alter the slug if it's already prefixed with \"screencast-\"" do
      @post.title = "Screencast: Awesome tutorial"
      @post.save
      @post.cached_slug.should == "screencast-awesome-tutorial"
    end
  end

  describe "#screencast?" do
    it "returns true if the post has a video_url" do
      @post.video_url = "path/to/a/video"
      @post.should be_a_screencast
    end

    it "returns false if the post doesn't have a video_url" do
      @post.should_not be_a_screencast
    end
  end
end
