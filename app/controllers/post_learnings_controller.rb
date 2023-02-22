class PostLearningsController < ApplicationController
  before_action :authenticate_user!
  before_action :genre_all, only: [:new, :create, :index, :show, :edit, :update, :search_genre, :destroy]
   before_action :ensure_correct_post_learning, only:[:edit]

  def new
    @post_learning = PostLearning.new
  end
  
  def create
    @post_learning = PostLearning.new(post_learning_params)
    @post_learning.user_id = current_user.id
    if @post_learning.save
      redirect_to post_learning_path(@post_learning.id)
      flash[:notice] = "投稿に成功しました"
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @post_learnings = PostLearning.page(params[:page]).per(10).order(created_at: :desc)

  end

  def show
    begin
      @post_learning = PostLearning.find(params[:id])
    rescue
      flash[:alert] = "入力された投稿はありません"
      redirect_to root_path
    else
      @post_comments = @post_learning.post_comments.order(created_at: :desc) 
      @post_comment = PostComment.new
    end
  end

  def edit
  end
  
  def update
    @post_learning = PostLearning.find(params[:id])
    if @post_learning.update(post_learning_params)
      redirect_to post_learning_path(@post_learning.id)
      flash[:notice] = "変更を保存できました"
    else
      flash[:alert] = "変更を保存できませんでした"
      render :edit
    end
  end
  
  def destroy
    @post_learning = PostLearning.find(params[:id])  
    @post_learning.destroy
    @post_learnings = PostLearning.page(params[:page]).per(10).order(created_at: :desc)
    flash[:notice] = "投稿を削除しました"
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

  def ensure_correct_post_learning
    begin
      @post_learning = PostLearning.find(params[:id])
    rescue
      flash[:alert] = "入力された投稿はありません"
      redirect_to user_path(current_user.id)
    else
      unless @post_learning.user == current_user
        if current_user.admin?
        else
          flash[:alert] = "他ユーザーの投稿は編集できません"
          redirect_to user_path(current_user.id)
        end
      end
    end
  end
end
 
