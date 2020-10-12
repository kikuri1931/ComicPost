class PicturesController < ApplicationController
  def new
    @picture = Picture.new
    @picture.picture_images.build
  end

  def create
    @picture = Picture.new picture_params
    @picture.user_id = current_user.id
    @picture.save
    redirect_to picture_path(@picture)
  end

  def show
    @picture = Picture.find(params[:id])
    @pictures = @picture.user.pictures.limit(3)
    @picture_images = @picture.picture_images
    @comment = Comment.new
  end

  def index
    @user = User.find(params[:user_id])
    @pictures = @user.pictures
  end

  def bookmarks
    @bookmarks = current_user.bookmarks
  end

  def comics
    if params[:user_id]
      @user = User.find(params[:user_id])
      @comic_pictures = @user.pictures.where(status: "マンガ")
    else
      @comic_pictures = Picture.where(status: "マンガ")
    end
  end

  def illustrations
    if params[:user_id]
      @user = User.find(params[:user_id])
      @illustration_pictures = @user.pictures.where(status: "イラスト")
    else
      @illustration_pictures = Picture.where(status: "イラスト")
    end
  end

  def edit
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :introduction, :genre_id, :status, picture_images_images: [])
  end
end
