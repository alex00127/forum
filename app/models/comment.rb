class Comment < ActiveRecord::Base
	validates_presence_of :content
	belongs_to :topic ,touch: :last_comment_time
	belongs_to :user
end
