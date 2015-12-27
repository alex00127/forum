class Admin::UsersController < ApplicationController
	layout "admin"

	def edit
		@user=User.find(params[:id])
	end

	def update
		@user=User.find(params[:id])
		if @user=@user.update(user_params)
			redirect_to admin_topics_path
			flash[:notice] = "User was successfully updated"
			
		else
			render :edit_admin_user_path
			#render :action => :edit
		end
	end




	private

	def user_params
		params.require(:user).permit(:user_name,:role)

	end
end
