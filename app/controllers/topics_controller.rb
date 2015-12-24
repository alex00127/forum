class TopicsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index]
  before_action :set_topic, :only => [:edit, :show, :destroy, :update]


	def index
    
    if params[:keyword]
      @topics = Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] )
                               # title like 是sql寫法

    else
     
        if (params[:category])
          @category = Category.find(params[:category])
          @topics = @category.topics
        else
           @topics = Topic.all
        end
    end

      #@topics = @topics.page(params[:page]).per(5)
      #sort_by = (params[:order] == 'title') ? 'title' : 'comment_count'
      if (params[:order])
        sort_by = (params[:order])
      else
        sort_by = 'title'
      end
  
     
      @topics = @topics.order(sort_by +' DESC').page(params[:page]).per(5)


      

      #raise

	    #@user = current_user

  end
  


  def show
  	@comments = @topic.comments 
    
  	#@a = Comment.find(params[:id])
  	if params[:comment_id]
      @comment = Comment.find(params[:comment_id])
    else
      @comment = Comment.new
    end

    if params[:view]
      @topic.view +=1
      @topic.save
    end
 
  end


	def new
    @topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
    @topic.view = 0
		@topic.user = current_user

		if @topic.save
		  redirect_to topics_path
		  flash[:notice] = "event was successfully created"
		else
			render :action => :new
		end
  end


  def edit
  end


	def update
		if @topic.update(topic_params)
		  redirect_to topics_path
		  flash[:notice] = "event was successfully updated"
		else
			render :action => :edit
		end
    
	end





  def destroy
  	@topic.destroy
  	flash[:alert] = "event was successfully deleted"
  	redirect_to :action => :index
  end

  def statistic
    #@topic = Topic.find(params[:id])
  end


  private

  def topic_params
  	params.require(:topic).permit(:title, :content, :category_ids => [])

  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
