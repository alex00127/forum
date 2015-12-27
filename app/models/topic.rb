class Topic < ActiveRecord::Base
	validates_presence_of :title 
	has_many :comments , dependent: :destroy


	belongs_to :user
	has_many :collectships, dependent: :destroy
	has_many :collected_users, :through => :collectships, :source => :user

  #belongs_to :category

  has_many :topic_categoryships, dependent: :destroy
	has_many :categories, :through => :topic_categoryships




  #delegate :name, :to => :category , :prefix => true, :allow_nil => true

end
