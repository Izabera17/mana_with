class PostLearningsController < ApplicationController
  
  def new
    @post_learning = PostLearning.new
  end
  
  def create
    @post_learning = PostLearning.new(post_learning_params)
    @post_learning.user_id = current_user.id
    if @post_learning.save
      redirect_to post_learning_path(@post_learning.id)
      flash[:notice] = "投稿できました"
    else
      render :new
      flash[:alert] = "投稿に失敗しました"
    end
  end

  def index
    @post_learnings = PostLearning.all
    @genres = Genre.all
  end

  def show
    @post_learning = PostLearning.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_learning = PostLearning.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    post_learning = PostLearning.find(params[:id])
    post_learning.update(post_learning_params)
    redirect_to post_learning_path(post_learning.id)  
  end

  def search
    @post_learnings = PostLearning.where(genre_id: params[:format]).page(params[:page]).per(5)
    @quantity = PostLearning.where(genre_id: params[:format]).count
    @genres = Genre.all
    @genre = @genres.find(params[:format])
    render 'index'
  end
  
  private
  
  def post_learning_params
    params.require(:post_learning).permit(:learning_name, :learning_content, :learning_real, :genre_id, :post_image)
  end

end
