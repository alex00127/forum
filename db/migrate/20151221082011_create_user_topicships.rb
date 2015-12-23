class CreateUserTopicships < ActiveRecord::Migration
  def change
    create_table :user_topicships do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end
