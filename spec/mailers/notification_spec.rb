require "spec_helper"

describe Notification do
  describe "#new_comment" do
    before do
      @comment = FactoryGirl.create(:comment)
      @email = Notification.new_comment(@comment).deliver
    end

    it "queues a message for new comments" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "sends email to and from the admin" do
      @email.to.should == [ENV['ADMIN_EMAIL']]
      @email.from.should == [ENV['ADMIN_EMAIL']]
    end

    it "sets an appropriate subject" do
      @email.subject.should == "New comment from #{@comment.name} on #{@comment.post.title}"
    end
  end
end
