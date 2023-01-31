class PostLearningsController < ApplicationController
  before_action :genre_all, only: [:new, :create, :index, :show, :edit, :search_genre, :destroy]

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
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @post_learnings = PostLearning.page(params[:page]).per(10).order(created_at: :desc)

  end

  def show
    @post_learning = PostLearning.find(params[:id])
    @post_comments = @post_learning.post_comments.order(created_at: :desc) 
    @post_comment = PostComment.new
  end

  def edit
    @post_learning = PostLearning.find(params[:id])
  end
  
  def update
    @post_learning = PostLearning.find(params[:id])
    if @post_learning.update(post_learning_params)
      redirect_to post_learning_path(@post_learning.id)
      flash[:notice] = "変更を保存できました"
    else
      @genres = Genre.all
      flash[:alert] = "変更を保存できませんでした"
      render :edit
    end
  end
  
  def destroy
    @post_learning = PostLearning.find(params[:id])  
    @post_learning.destroy
    @post_learnings = PostLearning.page(params[:page]).per(10).order(created_at: :desc)
    render 'index'  
  end

  def search_genre
    @post_learnings = PostLearning.where(genre_id: params[:format]).page(params[:page]).per(5)
    @quantity = PostLearning.where(genre_id: params[:format]).count
    @genre = @genres.find(params[:format])
    render 'index'
  end
  
  private
  
  def post_learning_params
    params.require(:post_learning).permit(:learning_name, :learning_content, :learning_real, :genre_id, :post_image)
  end
  
  def genre_all
    @genres = Genre.all
  end

end
