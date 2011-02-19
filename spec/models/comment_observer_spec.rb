require 'spec_helper'

describe CommentObserver do
  it "triggers the notification mailer after a new comment is created" do
    @comment = Factory.build(:comment)
    message = mock(::Mail::Message).as_null_object
    Notification.stub(:new_comment).and_return(message)
    Notification.should_receive(:new_comment).with(@comment)
    @comment.save
  end
end
