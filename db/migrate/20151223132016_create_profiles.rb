class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

    	t.string :first_name 
    	t.string :last_name 
    	t.date :birth
    	t.boolean :sex
    	t.text  :about_me
      t.integer :user_id

      t.timestamps null: false
    end
  

      #add_index :profile, :user_id
  end
end
