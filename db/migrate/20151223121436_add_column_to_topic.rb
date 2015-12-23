class AddColumnToTopic < ActiveRecord::Migration
  def change
  	add_column :topics, :last_comment_time, :datetime
  end
end
