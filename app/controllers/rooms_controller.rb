class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @genres = Genre.all
    begin
      @room = Room.find(params[:id])
    rescue
      flash[:alert] = "入力されたルームは存在しません"
      redirect_to root_path
    else
      if Entry.where(user_id: current_user.id,room_id: @room.id).present?
        @messages = @room.messages
        @message = Message.new
        @entries = @room.entries
      elsif current_user.admin?
        @messages = @room.messages
        @message = Message.new
        @entries = @room.entries
      else
        flash[:alert] = "他ユーザーのルームには入室できません"
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
