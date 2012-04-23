class AddPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean, default: false, null: false

    add_index :posts, :published

    Post.all.each { |p| p.update_attribute(:published, true) }
  end
end
