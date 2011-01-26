class AddUserFieldsToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :name, :string
    add_column :comments, :email, :string
    add_column :comments, :url, :string

    remove_column :comments, :user_id
  end

  def self.down
    remove_column :comments, :name
    remove_column :comments, :email
    remove_column :comments, :url

    add_column :comments, :user_id, :intger
  end
end
