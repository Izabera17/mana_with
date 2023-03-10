class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:favorites, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit]
  before_action :ensure_correct_user_show, only: [:show]
  before_action :genre_all, only: [:index, :show, :edit, :update, :destroy, :follow_list, :follower_list, :unsubscribe]
  before_action :room_entry, only: [:show]

  def index
    users = User.where.not(admin: 'true')
    @users = users.page(params[:page]).per(10)
  end

  def show
    @post_learnings = @user.post_learnings.page(params[:page])
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
    if @user.update(user_params)
      flash[:notice] = "プロフィールを変更しました"
      redirect_to user_path(@user.id)
    else
      flash[:alert] = "更新に失敗しました"
      render 'edit'
    end
  end
  
  def destroy
    if @user.email == 'guest@example.com'
      reset_session
      redirect_to :root
    else
      @user.destroy
      users = User.where.not(admin: 'true')
      @users = users.page(params[:page]).per(10)
      flash[:notice] = "退会しました"
      redirect_to root_path  
    end
  end
  
  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    redirect_to request.referer   
  end

  def unfollow
    @user = User.find(params[:user_id])
    current_user.stop_following(@user)
    redirect_to request.referer  
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
  
  def ensure_correct_user
    begin
      @user = User.find(params[:id])
    rescue
      flash[:alert] = "入力されたユーザーは存在しません"
      redirect_to user_path(current_user.id)
    else
      unless @user.id == current_user.id
        if current_user.admin?
        else
          flash[:alert] = "他ユーザーは編集できません"
          redirect_to user_path(current_user.id)
        end
      end
    end
  end
  
  def ensure_correct_user_show
    begin
      @user = User.find(params[:id])
    rescue
      flash[:alert] = "入力されたユーザーは存在しません"
      redirect_to user_path(current_user.id)
    else
    end
  end

  def genre_all
    @genres = Genre.all
  end
    
  def user_params
    params.require(:user).permit(:name, :email, :introduction, :user_image)
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
