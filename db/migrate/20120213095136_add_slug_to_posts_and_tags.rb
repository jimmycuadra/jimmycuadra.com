class AddSlugToPostsAndTags < ActiveRecord::Migration
  def change
    rename_column :posts, :cached_slug, :slug
    rename_column :tags, :cached_slug, :slug
  end
end
