class Admin::TopicsController < ApplicationController
  before_action :authenticate_user! # 這個是 devise 提供的方法，先檢查必須登入 
  before_action :authenticate_admin # 再檢查是否有權限 

  
#  before_action :authenticate
  
  layout "admin"

	def index
    @topics = Topic.all
    @categories = Category.all
    @users = User.all
    if params[:category_id]
      @category = Category.find(params[:category_id])   
    else
      @category = Category.new 
    end
	end
  
	protected
#  def authenticate
#    authenticate_or_request_with_http_basic do |user_name, password|
#      user_name == "username" && password == "password"
#    end
#  end

  def authenticate_admin 
   unless current_user.admin? 
     flash[:alert] = "Not allow!" 
     redirect_to topics_path 
   end
  end



end
