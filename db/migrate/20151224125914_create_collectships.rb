class CreateCollectships < ActiveRecord::Migration
  def change
    create_table :collectships do |t|
      t.integer :user_id
      t.integer :topic_id
      t.timestamps null: false
    end
  end
end