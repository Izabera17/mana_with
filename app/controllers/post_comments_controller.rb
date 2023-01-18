class PostCommentsController < ApplicationController
   def create
    post_learning = PostLearning.find(params[:post_learning_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_learning_id = post_learning.id
    
    if comment.save
      # コメントしたタイミングで通知レコードを作成
      post_learning.create_notification_post_comment!(current_user, comment.id)
      redirect_to post_learning_path(post_learning)
    else
      @error_comment = comment
      @genres = Genre.all
      @post_learning = PostLearning.find(params[:post_learning_id])
      @post_comment = PostComment.new
      render 'post_learnings/show'
    end
    
    # @post_learning = PostLearning.find(params[:post_learning_id])
    # #投稿に紐づいたコメントを作成
    # @post_comment = @post_learning.post_comments.new(post_comment_params)
    # @post_comment.user_id = current_user.id
    # @comment_post_learning = @post_comment.post_learning
    # if @post_comment.save
    #   #通知の作成
    #   @comment_post_learning.create_notification_post_comment!(current_user, @post_comment.id)
    #     render 'post_learnings/show'
    # end
    
    
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
