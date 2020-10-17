class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :room_operation_user
  def create
    @room = Room.create
    @currentUserEntry = Entry.create(room_id: @room.id, user_id: current_user.id)
    @userEntry = Entry.create(entry_params)
    redirect_to room_path(@room)
   end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
    else
      redirect_back(fallback_location: user_path(current_user))
    end
  end

  def index
    @rooms = current_user.rooms
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

  def room_operation_user
    if current_user.status == "無料会員"
      redirect_to user_path(current_user)
    end
  end
end
