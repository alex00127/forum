class Comment < ActiveRecord::Base
	validates_presence_of :content
	
	belongs_to :topic ,touch: :last_comment_time, :counter_cache => "comment_count" # true for comments_count
	belongs_to :user
end
