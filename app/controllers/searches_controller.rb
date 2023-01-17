class SearchesController < ApplicationController
  before_action :authenticate_user!
  before_action :genre_all, only: [:search_keyword]

  def search_keyword
    @range = params[:range]
    
    if @range == "ユーザー"
      users = User.looks(params[:word])
      @users = users.where.not(admin: 'true')
    else
      @post_learnings = PostLearning.looks(@range, params[:word])
    end
  end
  
  private
  
  def genre_all
    @genres = Genre.all
  end
  
end
