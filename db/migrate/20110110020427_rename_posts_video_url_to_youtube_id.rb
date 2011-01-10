class RenamePostsVideoUrlToYoutubeId < ActiveRecord::Migration
  def self.up
    rename_column :posts, :video_url, :youtube_id
  end

  def self.down
    rename_column :posts, :youtube_id, :video_url
  end
end
