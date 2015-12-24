class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics
  has_many :comments

  has_many :user_topicships
	has_many :favorited_topics, :through => :user_topicships, :source => :topic

  has_one :profile

  def short_name
  	self.email.split("@").first
  end

end
