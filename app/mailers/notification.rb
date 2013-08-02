class Notification < ActionMailer::Base
  def new_comment(comment)
    @comment = comment
    mail to: ENV['ADMIN_EMAIL'], from: ENV['ADMIN_EMAIL'], subject: "New comment from #{@comment.name} on #{@comment.post.title}"
  end
end
