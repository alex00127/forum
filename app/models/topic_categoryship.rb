class TopicCategoryship < ActiveRecord::Base
	belongs_to :category
	belongs_to :topic
end