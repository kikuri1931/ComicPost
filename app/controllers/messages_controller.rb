class MessagesController < ApplicationController
	before_action :set_room
	def create
	    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
	      @message = Message.create(message_params)
	    else
	      flash[:alert] = "メッセージ送信に失敗しました。"
	    end
	    redirect_to room_path(@message.room_id)
  	end

  	private
  	def set_room
  		@room = Room.find(params[:message][:room_id])
  	end

  	def message_params
  		params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  	end
end
