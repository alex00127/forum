class UserProfilesController < ApplicationController

	before_action :authenticate_user!, :except => [:show]


	def show
		@user = User.find(params[:user_id])

		if @user.profile
		  @profile = @user.profile
	  else
	  	@user.profile = Profile.create
	  end
	end

	def update
		@user = current_user

		@profile = @user.profile
		@profile.update(profile_params)

		redirect_to user_profile_path(@user)
	end

	private

  def profile_params
    params.require(:profile).permit(:first_name,:last_name,:birth,:sex,:about_me)
  end

end
