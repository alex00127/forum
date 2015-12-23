class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :content
      t.string :status
      t.datetime :date

      t.timestamps null: false
    end
  end
end
