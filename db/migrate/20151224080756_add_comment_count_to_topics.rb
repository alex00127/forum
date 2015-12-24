class AddCommentCountToTopics < ActiveRecord::Migration
  def change
  	  	add_column :topics, :comment_count, :integer
  end
end
