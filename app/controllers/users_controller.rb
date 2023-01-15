class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites, :edit]
  before_action :genre_all, only: [:show, :edit]

  def index

  end

  def show
    @post_learnings = @user.post_learnings

    favorites = Favorite.where(user_id: @user.id).pluck(:post_learning_id)
    @favorite_posts = PostLearning.find(favorites)
  end

  def edit
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def genre_all
      @genres = Genre.all
    end
end
