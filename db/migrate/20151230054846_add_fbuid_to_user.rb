class AddFbuidToUser < ActiveRecord::Migration
  def change
  	 add_column :users, :fb_uid, :string
     add_index :users, :fb_uid
  end
end
