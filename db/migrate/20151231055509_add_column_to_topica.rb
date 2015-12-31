class AddColumnToTopica < ActiveRecord::Migration
  def change
  	add_column :subscriptions, :user_id, :integer , :index=>true
  	add_column :subscriptions, :topic_id, :integer , :index=>true
  end
end
