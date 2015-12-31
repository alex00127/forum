class TopicCommentsController < ApplicationController
	
  before_action :authenticate_user!
  before_action :set_topic

  def create
    @comment = Comment.new(comment_params)
    @comment.topic = @topic
    @comment.user = current_user

    if @comment.save
    	redirect_to topic_path(@topic)
    else
      render "topics/show"
    end
  end

  def destroy
  	@comment = current_user.comments.find(params[:id])
  	@comment.destroy

  	redirect_to topic_path(@topic)
  end

  def update
    @comment = current_user.comments.find(params[:id])
   
    if @comment.update(comment_params)      
      redirect_to topic_path(@topic)
    else
      render "topics/show"
    end
  end

  private
  

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end

