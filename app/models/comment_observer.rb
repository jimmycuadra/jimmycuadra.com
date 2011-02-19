class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    Notification.new_comment(comment).deliver
  end
end
