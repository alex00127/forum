class Admin::TopicsController < ApplicationController
  
  before_action :authenticate
  
  layout "admin"

	def index
    @topics=Topic.all
	end

	def new
		@topic = Topic.new
	end



	protected

  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "username" && password == "password"
    end
  end


end
