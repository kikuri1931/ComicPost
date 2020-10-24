class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :edit_possible_user, only: [:edit,:update]
  before_action :index_access_user, only: [:index]

  def index
    @users = User.where(status: ["無料会員", "有料会員"])
  end

  def show
    @user = User.find(params[:id])
    if @user.is_deleted == true && ["有料会員", "無料会員"].include?(current_user.status)
      redirect_to user_path(current_user)
    end
    # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック
    if user_signed_in? && @user != current_user
      login_user_check_entry = current_user.login_user_check_entry(@user)
      if login_user_check_entry[:isRoom]
        @isRoom = login_user_check_entry[:isRoom]
        @roomId = login_user_check_entry[:roomId]
      else
        @room = login_user_check_entry[:room]
        @entry = login_user_check_entry[:entry]
      end
    end
    # @userとログインユーザがEntryモデルに相互登録されていることを確かめるロジック
    @comic_pictures = @user.pictures.user_picture_limit5("マンガ")
    @illustration_pictures = @user.pictures.user_picture_limit5("イラスト")
    @pictures = Picture.joins(:genre).where(genres: {is_active: true}).limit(5)   
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

  def withdraw
    @user = User.find(current_user.id)
    if @user.update(is_deleted: true)   
      reset_session
      redirect_to root_path, alert: "退会処理が完了しました。今までのご利用ありがとうございました。"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user)
          .permit(:name, :name_kana, :profile_image, :nickname, :postal_code, :address, :telephone_number, :email, :status, :is_deleted)
  end

  def edit_possible_user
    @user = User.find(params[:id])
    unless @user == current_user || current_user.status == "講師"
      redirect_to user_path(current_user)
    end
  end

  def index_access_user
    unless current_user.status == "講師"
      redirect_to user_path(current_user)
    end
  end
end
