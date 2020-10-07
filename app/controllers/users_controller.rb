class UsersController < ApplicationController
  def show
  	 @user = User.find(params[:id])
  	 @comic_pictures = @user.pictures.where(status: "マンガ").limit(5)
  	 @illustration_pictures = @user.pictures.where(status: "イラスト").limit(5)
  end

  def edit
  end
end
