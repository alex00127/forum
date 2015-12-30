class AddOmniauthToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :fb_id, :string
    add_column :users, :fb_token, :string

    add_index :users, :fb_id
  end
end
