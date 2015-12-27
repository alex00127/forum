class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  ROLE_ADMIN = 'admin'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :topics
  has_many :comments

  has_many :collectships
	has_many :favorited_topics, :through => :collectships, :source => :topic

  has_one :profile , dependent: :destroy, dependent: :destroy

  def short_name
  	self.email.split("@").first
  end

  def admin? 
    self.role == ROLE_ADMIN
  end

end
