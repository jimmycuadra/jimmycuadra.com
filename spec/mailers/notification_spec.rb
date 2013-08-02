require "spec_helper"

describe Notification do
  describe "#new_comment" do
    before do
      @comment = FactoryGirl.create(:comment)
      @email = Notification.new_comment(@comment).deliver
    end

    it "queues a message for new comments" do
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it "sends email to and from the admin" do
      expect(@email.to).to eq([ENV['ADMIN_EMAIL']])
      expect(@email.from).to eq([ENV['ADMIN_EMAIL']])
    end

    it "sets an appropriate subject" do
      expect(@email.subject).to eq <<-SUBJECT.chomp
New comment from #{@comment.name} on #{@comment.post.title}
SUBJECT
    end
  end
end
