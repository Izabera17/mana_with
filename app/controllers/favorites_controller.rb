class FavoritesController < ApplicationController
  def create
    post_learning = PostLearning.find(params[:post_learning_id])
    post_learning.create_notification_favorite!(current_user)
    favorite = current_user.favorites.new(post_learning_id: post_learning.id)
    favorite.save
    post_learning.create_notification_favorite!(current_user)
    redirect_to request.referer 
  end

  def destroy
    post_learning = PostLearning.find(params[:post_learning_id])
    favorite = current_user.favorites.find_by(post_learning_id: post_learning.id)
    favorite.destroy
    redirect_to request.referer 
  end

end


