class Admin::PostLearningsController < ApplicationController
  before_action :authenticate_user!
  before_action :if_not_admin
  before_action :set_post_learning, only: [:index]
  
  def index 
    @post_comments = PostLearning.all
  end
  
  private
  
  def if_not_admin
    redirect_to home_path unless current_user.admin?
  end

  def set_post_learning
    @post_learning = PostLearning.find(params[:id])
  end
  
end
