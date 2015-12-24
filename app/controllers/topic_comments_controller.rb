class TopicCommentsController < ApplicationController
	before_action :find_event



def create
  @comment = @topic.comments.build(comment_params)
  @comment.user = current_user


  if @comment.save
    #@topic.last_comment_time = @comment.created_at
    @topic.comment_count = @topic.comments.size
    @topic.save!
  	redirect_to topic_path(@topic)
  else
  	redirect_to topic_path(@topic)
  end
end

def destroy
	@comment = @topic.comments.find(params[:id])

	@comment.destroy
  @topic.comment_count = @topic.comments.size
  @topic.save!
	redirect_to topic_path(@topic)
end

def update
  @comment = @topic.comments.find(params[:id])
 
  if @comment.update(comment_params)
    
    redirect_to topic_path(@topic)
  else
    redirect_to topic_path(@topic)
  end
end



private
  def find_event
	  @topic = Topic.find(params[:topic_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end

