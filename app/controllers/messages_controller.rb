class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id))
      if @message.save
        @room = @message.room
        @room.create_notification_dm(current_user, @message.id)
        # 本引数を２つ持たせてcreate_notification_dmメソッドを実行
        flash[:notice] = "送信に成功しました"
        redirect_back(fallback_location: root_path)
      else
         flash[:alert] = "送信に失敗しました"
         @room = @message.room
         redirect_to room_path(@message.room_id)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to room_path(@message.room_id)
  end
  
end 



