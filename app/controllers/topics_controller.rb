class TopicsController < ApplicationController
  
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_topic, :only => [:edit, :show, :destroy, :update, :collect, :non_collect]

	def index
    params[:keyword]
      @topics = Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] )                             # title like 是sql寫法
    if (params[:category])
      @category = Category.find(params[:category])
      @topics = @category.topics
    else
      @topics = Topic.order('id DESC')
    end

    # ["title", "comment_count", "last_comment_time", "view"]
    if %w[title comment_count last_comment_time view].include?(params[:order])
      sort_by = (params[:order])
    else
      sort_by = 'id'
    end

    @topics = @topics.where( :status => 'publish' ).order(sort_by +' DESC').page(params[:page]).per(5) 
  end

  def show
  	@comments = @topic.comments 

  	if params[:comment_id]
      @comment = @topic.comments.find(params[:comment_id])
    else
      @comment = Comment.new
    end

    @topic.view = @topic.view.to_i + 1
    @topic.save
    # @topic.update( :view => @topic.view + 1 )
    # @topic.increment(:view)
  end

	def new
    @topic = Topic.new
	end

	def create
		@topic = current_user.topics.new(topic_params)
    @topic.view = 0

    if params[:commit] == "Publish"
      @topic.status = "publish"
    else
      @topic.status = "draft"
    end

    if @topic.save
      redirect_to topics_path 
      flash[:notice] = "Topic was successfully created"
    else
      render :action => :new  # or render :new
    end
  end

  def edit
  end

	def update
    if params[:_remove_logo] == "1"
      @topic.logo = nil
    end

    if (params[:commit] == "Publish") ||(params[:commit] == "Save") 
      @topic.status = "publish"
    else
      @topic.status = "draft"
    end

    if @topic.update(topic_params)
		  redirect_to topics_path
		  flash[:notice] = "Topic was successfully updated"
		else
			render "edit"
		end    
	end

  def destroy
  	@topic.destroy
  	flash[:alert] = "Topic was successfully deleted"
  	redirect_to topics_path
  end

  def statistic
    #@topic = Topic.find(params[:id])
  end

  def collect
    @collectship = Collectship.find_or_create_by( :topic => @topic, :user => current_user )
    redirect_to :back
  end
  #也可以另建一個collect的controller自己CRUD

  def non_collect
    @collectship = Collectship.find_by( :topic => @topic, :user => current_user )
    @collectship.destroy
    redirect_to :back
  end

  # POST /topics/:id/subscribe
  def subscribe
    @topic = Topic.find( params[:id] )
    @topic.subscriptions.create!( :user => current_user )
    respond_to do |format|
      format.html{redirect_to :back}
      format.js 
    end

    #redirect_to :back
  end

  def unsubscribe
    @topic = Topic.find( params[:id] )
    current_user.subscriptions.where( :topic_id => @topic.id ).destroy_all
    respond_to do |format|
      format.html{redirect_to :back}
      format.js {render "subscribe"}
    end
    #redirect_to :back
  end
  

  private

  def topic_params
  	params.require(:topic).permit(:title, :logo, :content, :category_ids => [])
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
