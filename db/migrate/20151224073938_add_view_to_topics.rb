class AddViewToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :view, :integer
  end
end
