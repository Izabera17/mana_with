class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites, :edit, :update, :destroy]
  before_action :genre_all, only: [:index, :show, :edit, :destroy]

  def index
    @users = User.where.not(admin: 'true')
  end

  def show
    @post_learnings = @user.post_learnings
    favorites = Favorite.where(user_id: @user.id).pluck(:post_learning_id)
    @favorite_posts = PostLearning.find(favorites)
  end

  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)  
  end
  
  def destroy
    @user.destroy
    render 'index'  
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
