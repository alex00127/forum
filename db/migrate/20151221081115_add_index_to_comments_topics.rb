class AddIndexToCommentsTopics < ActiveRecord::Migration
  def change

  	add_index :topics, :user_id
  	add_index :comments, :user_id



  end
end
