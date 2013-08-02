class RemoveLimitFromCommentText < ActiveRecord::Migration
  def self.up
    change_column :comments, :comment, :text, limit: false
  end

  def self.down
    change_column :comments, :comment, :text, limit: 255
  end
end
