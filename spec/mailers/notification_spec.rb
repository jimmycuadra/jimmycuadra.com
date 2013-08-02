require "spec_helper"

describe Notification do
  describe "#new_comment" do
    let(:comment) { FactoryGirl.create(:comment) }
    let(:email) { Notification.new_comment(comment).deliver }

    it "queues a message for new comments" do
      email
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it "sends email to and from the admin" do
      expect(email.to).to eq([ENV['ADMIN_EMAIL']])
      expect(email.from).to eq([ENV['ADMIN_EMAIL']])
    end

    it "sets an appropriate subject" do
      expect(email.subject).to eq <<-SUBJECT.chomp
New comment from #{comment.name} on #{comment.post.title}
SUBJECT
    end
  end
end
