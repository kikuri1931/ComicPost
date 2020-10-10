class UsersController < ApplicationController

  def index
    @users = User.where(status: ['無料会員', '有料会員'])
  end

  def show
  	@user = User.find(params[:id])

    if user_signed_in?
  	  @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
           	if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  	@comic_pictures = @user.pictures.where(status: "マンガ").limit(5)
  	@illustration_pictures = @user.pictures.where(status: "イラスト").limit(5)
  end

  def edit
  end
end
