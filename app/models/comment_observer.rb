class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    Notification.new_comment(comment).deliver unless comment.email == ENV['ADMIN_EMAIL']
  end
end
