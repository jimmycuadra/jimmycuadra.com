# coding: utf-8
require 'spec_helper'

describe Post do
  let(:post) { FactoryGirl.build(:post) }

  it "saves valid records" do
    expect(post).to be_valid
  end

  it "requires a title" do
    post.title = nil
    post.valid?
    expect(post).to have(1).error_on(:title)
  end

  it "requires a body" do
    post.body = nil
    post.valid?
    expect(post).to have(1).error_on(:body)
  end

  it "destroys associated comments when destroyed" do
    post.save
    FactoryGirl.create(:comment, post_id: post.id)
    post.reload.destroy
    expect(Comment.count).to eq(0)
  end

  it "generates a slug when saved" do
    post.save
    expect(post.slug).not_to be_nil
  end

  it "approximates ASCII in generated slugs" do
    post.title = "My résumé"
    post.save
    expect(post.slug).to eq("my-resume")
  end

  it "converts underscores to dashes in generated slugs" do
    post.title = "this_has_underscores"
    post.save
    expect(post.slug).to eq("this-has-underscores")
  end

  context "with a video" do
    before do
      post.youtube_id = "abc123"
    end

    context "with a title beginning with \"Screencast: \"" do
      before do
        post.title = "Screencast: Awesome tutorial"
        post.save
      end

      it "doesn't alter the title" do
        expect(post.title).to eq("Screencast: Awesome tutorial")
      end

      it "doesn't alter the slug" do
        expect(post.slug).to eq("screencast-awesome-tutorial")
      end
    end

    context "with a title not beginning with \"Screencast: \"" do
      before do
        post.title = "Awesome tutorial"
        post.save
      end

      it "prepends the title with \"Screencast: \"" do
        expect(post.title).to eq("Screencast: Awesome tutorial")
      end

      it "prepends the slug with \"screencast-\"" do
        expect(post.slug).to eq("screencast-awesome-tutorial")
      end
    end

    it "adds \"screencast\" to the tag list if not present" do
      post.tag_list = "foo"
      post.save
      expect(post.tag_list).to eq(["foo", "screencast"])
    end
  end

  describe "#screencast?" do
    it "returns true if the post has a youtube_id" do
      post.youtube_id = "abc123"
      expect(post).to be_a_screencast
    end

    it "returns false if the post doesn't have a youtube_id" do
      expect(post).not_to be_a_screencast
    end
  end

  describe "with tags" do
    before do
      post.tag_list = "ruby, to_lang, rails 3"
      post.save
    end

    it "associates itself with the tags" do
      expect(post.tags.map(&:name)).to eq(["ruby", "to_lang", "rails 3"])
    end

    it "updates tag associations when updated" do
      post.tag_list = "ruby, rails 3"
      post.save
      expect(post.tags.map(&:name)).to eq(["ruby", "rails 3"])
    end

    it "destroys orphaned tags when the post is saved" do
      post.tag_list = "ruby, rails 3"
      post.save
      expect(ActsAsTaggableOn::Tag.count).to eq(2)
    end

    it "destroys orphaned tags when the post is destroyed" do
      FactoryGirl.create(:post, tag_list: "ruby")
      post.reload.destroy
      expect(ActsAsTaggableOn::Tag.count).to eq(1)
    end

  end

  describe "#comments_allowed?" do
    it "returns false if the post is older than 2 weeks" do
      post = FactoryGirl.build(:post, created_at: 3.weeks.ago)
      expect(post.comments_allowed?).to be_false
    end

    it "returns true if the post is newer than 2 weeks" do
      post.save
      expect(post.comments_allowed?).to be_true
    end
  end
end
