class PostCommentsController < ApplicationController
   def create
    post_learning = PostLearning.find(params[:post_learning_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_learning_id = post_learning.id
    comment.save
    redirect_to post_learning_path(post_learning)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_learning_path(params[:post_learning_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
