class PostCommentsController < ApplicationController
   def create
    post_learning = PostLearning.find(params[:post_learning_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_learning_id = post_learning.id
    
    if comment.save
      # コメントしたタイミングで通知レコードを作成
      post_learning.create_notification_post_comment!(current_user, comment.id)
      redirect_to post_learning_path(post_learning)
      flash[:notice] = "コメントを送信しました"
    else
      flash[:alert] = "送信に失敗しました"
      @genres = Genre.all
      @post_learning = PostLearning.find(params[:post_learning_id])
      @post_comments = @post_learning.post_comments.order(created_at: :desc) 
      @post_comment = PostComment.new
      @error_comment = comment
      render 'post_learnings/show'
    end

  end
  
  
  def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_learning_path(params[:post_learning_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
