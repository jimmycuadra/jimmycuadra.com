class AddCachedSlugToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :cached_slug, :string

    add_index :tags, :cached_slug, unique: true
  end

  def self.down
    remove_column :tags, :cached_slug
  end
end
