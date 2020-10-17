class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :edit_possible_user, only: [:edit,:update]
  def index
    @users = User.where(status: ['無料会員', '有料会員'])
  end

  def show
    @user = User.find(params[:id])

    # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
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
    # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック
    
    @comic_pictures = @user.pictures.where(status: "マンガ").order(id: "DESC").limit(5)
    @illustration_pictures = @user.pictures.where(status: "イラスト").order(id: "DESC").limit(5)

    if Favorite.exists?
      @pictures = Picture.find(Favorite.group(:picture_id).order('count(picture_id) desc').limit(5).pluck(:picture_id))
    else
      @pictures = Picture.joins(:genre).where(genres: {is_active: true}).order(id: "DESC").limit(5)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :name_kana, :profile_image, :nickname, :postal_code, :address, :telephone_number, :email, :status, :is_deleted)
  end

  def edit_possible_user
    @user = User.find(params[:id])
    unless @user == current_user || current_user.status == "講師"
      redirect_to user_path(current_user)
    end
  end
end
