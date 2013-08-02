class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :video_url, default: nil
      t.string :cached_slug

      t.timestamps
    end

    add_index :posts, :cached_slug, unique: true
  end

  def self.down
    drop_table :posts
  end
end
