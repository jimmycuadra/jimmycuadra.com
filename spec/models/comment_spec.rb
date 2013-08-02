require 'spec_helper'

describe Comment do
  before do
    @post = FactoryGirl.create(:post)
    @comment = @post.comments.build(FactoryGirl.attributes_for(:comment))
  end

  it "saves valid records" do
    expect(@comment).to be_valid
  end

  it "requires a name" do
    @comment.name = nil
    @comment.valid?
    expect(@comment).to have(1).error_on(:name)
  end

  it "requires an email address" do
    @comment.email = nil
    @comment.valid?
    expect(@comment).to have(1).error_on(:email)
  end

  it "requires email addresses are a valid format" do
    @comment.email = "not an email address"
    @comment.valid?
    expect(@comment).to have(1).error_on(:email)
  end

  it "prepends http:// to the URL before saving if a URL is provided" do
    @comment.url = "example.com"
    @comment.save
    expect(@comment.url).to match(%r{^http://})
  end

  it "doesn't prepend http:// if the URL already has it" do
    original_url = @comment.url
    @comment.save
    expect(@comment.url).to eq(original_url)
  end

  it "doesn't prepend http:// if the URL starts with https://" do
    original_url = @comment.url = "https://example.com/"
    @comment.save
    expect(@comment.url).to eq(original_url)
  end

  it "doesn't prepend http:// to the URL if no URL is provided" do
    @comment.url = nil
    @comment.save
    expect(@comment.url).to be_blank
  end

  it "requires a comment" do
    @comment.comment = nil
    @comment.valid?
    expect(@comment).to have(1).error_on(:comment)
  end

  it "autofills fields if the commenter is the admin" do
    @comment = @post.comments.build(comment: "I'm an admin!")
    @comment.admin!
    expect(@comment).to be_valid
  end

  it "triggers the notification mailer after a new comment is created" do
    @comment = FactoryGirl.build(:comment)
    message = double("Mail::Message").as_null_object
    expect(Notification).to receive(:new_comment).with(@comment).and_return(
      message
    )
    @comment.save
  end

  it "does not trigger the notification mailer if the comment was made by the admin" do
    ENV['ADMIN_EMAIL'] = "admin@example.com"
    @comment = FactoryGirl.build(:comment, email: ENV['ADMIN_EMAIL'])
    expect(Notification).not_to receive(:new_comment)
    @comment.save
  end
end
