class WelcomesController < ApplicationController
	def jquery
    @todos = ["aaa","bbb","ccc"]
	end

def ajaxtest

    respond_to do |format|
      format.html{
        render :layout => false
      }
      format.js # ajaxtest.js.erb
      format.json {
        render :json => { :title => "ABC", :content => "XYZ" }
      }
    end
end


end
