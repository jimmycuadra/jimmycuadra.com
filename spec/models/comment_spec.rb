require 'spec_helper'

describe Comment do
  before(:each) do
    @post = Factory(:post)
    @comment = @post.comments.build(Factory.attributes_for(:comment))
  end

  it "saves valid records" do
    @comment.should be_valid
  end

  it "requires a name" do
    @comment.name = nil
    @comment.valid?
    @comment.should have(1).error_on(:name)
  end

  it "requires an email address" do
    @comment.email = nil
    @comment.valid?
    @comment.should have(1).error_on(:email)
  end

  it "requires email addresses are a valid format" do
    @comment.email = "not an email address"
    @comment.valid?
    @comment.should have(1).error_on(:email)
  end

  it "requires URLs to be a valid format" do
    @comment.url = "not a URL"
    @comment.valid?
    @comment.should have(1).error_on(:url)
  end

  it "prepends the protocol to the URL if absent" do
    @comment.url = "example.com"
    @comment.should be_valid
  end

  it "requires a comment" do
    @comment.comment = nil
    @comment.valid?
    @comment.should have(1).error_on(:comment)
  end
end
