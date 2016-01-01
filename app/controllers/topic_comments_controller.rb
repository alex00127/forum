class TopicCommentsController < ApplicationController
	
  before_action :authenticate_user!
  
  before_action :set_topic

  def create
    @comment = Comment.new(comment_params)
    @comment.topic = @topic
    @comment.user = current_user

    #if @comment.save
    #	redirect_to topic_path(@topic)
    #else
     # render "topics/show"
    #end
  #end
    @comment.save

    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end



  def destroy
  	@comment = current_user.comments.find(params[:id])
  	@comment.destroy

  	respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_params)      

  end

  private
  

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end

