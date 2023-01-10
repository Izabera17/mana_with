class PostLearningsController < ApplicationController
  before_action :set_q, only: [:index, :search]
  
  def new
    @post_learning = PostLearning.new
  end
  
  def create
    post_learning = List.new(post_learning_params)
    post_learning.save
    redirect_to '/home'
  end

  def index
    post_learnings = PostLearning.all
  end

  def show
  end

  def edit
  end
  
  def search
    # @post_learnings = PostLearning.where(genre_id: params[:format]).page(params[:page]).per(8)
    # @quantity = PostLearning.where(genre_id: params[:format]).count
    @genres = Genre.all
    @genre = @genres.find(params[:format])
    render 'index'
  end
  
  private
  
  def post_learning_params
    params.require(:post_learning).permit(:learning_name, :learning_content, :categories)
  end

end
