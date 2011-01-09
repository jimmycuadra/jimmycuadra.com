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
    it "returns true if the post has a video_url" do
      @post.video_url = "path/to/a/video"
      @post.should be_a_screencast
    end

    it "returns false if the post doesn't have a video_url" do
      @post.should_not be_a_screencast
    end
  end
end
