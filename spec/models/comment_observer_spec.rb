require 'spec_helper'

describe CommentObserver do
  it "triggers the notification mailer after a new comment is created" do
    @comment = FactoryGirl.build(:comment)
    message = mock(::Mail::Message).as_null_object
    Notification.stub(:new_comment).and_return(message)
    Notification.should_receive(:new_comment).with(@comment)
    @comment.save
  end

  it "does not trigger the notification mailer if the comment was made by the admin" do
    ENV['ADMIN_EMAIL'] = "admin@example.com"
    @comment = FactoryGirl.build(:comment, :email => ENV['ADMIN_EMAIL'])
    Notification.should_not_receive(:new_comment)
    @comment.save
  end
end
