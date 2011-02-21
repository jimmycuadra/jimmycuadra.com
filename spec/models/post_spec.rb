# coding: utf-8
require 'spec_helper'

describe Post do
  before do
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

  it "destroys associated comments when destroyed" do
    @post.save
    Factory(:comment, :post_id => @post.id)
    @post.destroy
    Comment.count.should == 0
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
    before do
      @post.youtube_id = "abc123"
    end

    context "with a title beginning with \"Screencast: \"" do
      before do
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
      before do
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

    it "adds \"screencast\" to the tag list if not present" do
      @post.tag_list = "foo"
      @post.save
      @post.tag_list.should == ["foo", "screencast"]
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
    before do
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

  describe "#comments_allowed?" do
    it "returns false if the post is older than 2 weeks" do
      @post = Factory.build(:post, :created_at => 3.weeks.ago)
      @post.comments_allowed?.should == false
    end

    it "returns true if the post is newer than 2 weeks" do
      @post.save
      @post.comments_allowed?.should == true
    end
  end
end
