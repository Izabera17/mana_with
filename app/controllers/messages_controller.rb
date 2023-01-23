class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id))
      @room = @message.room
      # 本引数を２つ持たせてcreate_notification_dmメソッドを実行
      @room.create_notification_dm(current_user, @message.id)
      redirect_to room_path(@message.room_id)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to room_path(@message.room_id)
  end
  
end 



