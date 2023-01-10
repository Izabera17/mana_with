class FavoritesController < ApplicationController
  def create
    post_learning = PostLearning.find(params[:post_learning_id])
    favorite = current_user.favorites.new(post_learning_id: post_learning.id)
    favorite.save
    redirect_to post_learning_path(post_learning)
  end
  
  def destroy
    post_learning = PostLearning.find(params[:post_learning_id])
    favorite = current_user.favorites.find_by(post_learning_id: post_learning.id)
    favorite.destroy
    redirect_to post_learning_path(post_learning)
  end
end
