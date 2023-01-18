class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites, :edit, :update, :destroy]
  before_action :genre_all, only: [:index, :show, :edit, :destroy, :follow_list, :follower_list]
  before_action :room_entry, only: [:show]

  def index
    @users = User.where.not(admin: 'true')
  end

  def show
    @post_learnings = @user.post_learnings
    favorites = Favorite.where(user_id: @user.id).pluck(:post_learning_id)
    @favorite_posts = PostLearning.find(favorites)
    
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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
  
  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    redirect_to user_path(@user.id)
  end

  def unfollow
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    redirect_to user_path(@user.id)
  end

  def follow_list
    user = User.find(params[:user_id])
    @users = user.all_following
  end

  def follower_list
    user = User.find(params[:user_id])
    @users = user.followers
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
  
  def room_entry 
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

end
