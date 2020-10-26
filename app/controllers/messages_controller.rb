class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :message_operation_user
  before_action :set_room
  
  def create
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @message = Message.create(message_params)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    @messages = @room.messages
    end

  private
  def set_room
    @room = Room.find(params[:message][:room_id])
  end

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end

  def message_operation_user
    if current_user.status == "無料会員"
      redirect_to user_path(current_user)
    end
  end
end
