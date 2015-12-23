class Topic < ActiveRecord::Base
	validates_presence_of :title 
	has_many :comments


	belongs_to :user
	has_many :user_topicships
	has_many :favorited_users, :through => :user_topicships, :source => :user

  belongs_to :category

  delegate :name, :to => :category , :prefix => true, :allow_nil => true

end
