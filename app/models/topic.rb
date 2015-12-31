class Topic < ActiveRecord::Base

  STATUS = ["publish", "draft"]

  validates_inclusion_of :status, :in => STATUS

	validates_presence_of :title 
	has_many :comments , dependent: :destroy

  belongs_to :user

	has_many :collectships, dependent: :destroy
	has_many :collected_users, :through => :collectships, :source => :user

  #belongs_to :category

  has_many :topic_categoryships, dependent: :destroy
	has_many :categories, :through => :topic_categoryships

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  has_many :subscriptions, :dependent => :destroy
  has_many :subscribed_users, :through => :subscriptions, :source => :user



  def find_my_like(u)
    if u
      self.likes.where( :user_id => u.id ).first
    else
      nil
    end
  end

  
  def find_my_subscription(u)
    if u
      self.subscriptions.where( :user_id => u.id ).first
    else
      nil
    end
  end



  #delegate :name, :to => :category , :prefix => true, :allow_nil => true

  #delegate :display_name, :to => :user , :prefix => true, :allow_nil => true

  def draft?
    self.status == "Draft" || self.status == "draft" 
  end

  def can_edit_by?(u)
  	u && ( self.user == u || u.admin? )
  end

  def user_display_name
  	if user
  		user.display_name
  	else
  		"No author"
  	end
  end

end
