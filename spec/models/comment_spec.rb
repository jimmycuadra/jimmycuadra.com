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

  it "prepends http:// to the URL before saving if a URL is provided" do
    @comment.url = "example.com"
    @comment.save
    @comment.url.should =~ /^http:\/\//
  end

  it "doesn't prepend http:// if the URL already has it" do
    original_url = @comment.url
    @comment.save
    @comment.url.should == original_url
  end

  it "doesn't prepend http:// if the URL starts with https://" do
    original_url = @comment.url = "https://example.com/"
    @comment.save
    @comment.url.should == original_url
  end

  it "doesn't prepend http:// to the URL if no URL is provided" do
    @comment.url = nil
    @comment.save
    @comment.url.should be_blank
  end

  it "requires a comment" do
    @comment.comment = nil
    @comment.valid?
    @comment.should have(1).error_on(:comment)
  end
end
