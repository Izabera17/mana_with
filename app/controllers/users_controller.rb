class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites, :edit, :update]
  before_action :genre_all, only: [:index, :show, :edit]

  def index
    @users = User.where.not(admin: 'true')
  end

  def show
    @post_learnings = @user.post_learnings
    @post_learning = PostLearning.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_learning_id)
    @favorite_posts = PostLearning.find(favorites)
  end

  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)  
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def genre_all
    @genres = Genre.all
  end
    
  def user_params
    params.require(:user).permit(:name, :emwil, :introduction, :user_image)
  end
end
