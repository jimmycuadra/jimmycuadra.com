class DeleteUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
  end

  def self.down
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :url

      t.timestamps
    end
  end
end
