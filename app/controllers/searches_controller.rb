class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :genre_all, only: [:search_keyword]

  def search_keyword
    @range = params[:range]
    
    if @range == "ユーザー名"
      users = User.looks(params[:word])
      users_admin = users.where.not(admin: 'true')
      @users = users_admin.where.not(email: 'guest@example.com')
    else
      @post_learnings = PostLearning.looks(@range, params[:word])
    end
  end
  
  private
  
  def genre_all
    @genres = Genre.all
  end
  
end
