class AddLogoToTopic < ActiveRecord::Migration
  def change
    add_attachment :topics, :logo
  end
end
