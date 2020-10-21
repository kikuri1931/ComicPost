class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :picture_operation_user, only: [:new,:create,:destroy]
  def new
    @picture = Picture.new
    @picture.picture_images.build
  end

  def create
    @picture = Picture.new picture_params
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to picture_path(@picture)
    else 
      render :new
    end
  end

  def show
    @picture = Picture.find(params[:id])
    @pictures = @picture.user.pictures.limit(3)
    @picture_images = @picture.picture_images
    @comment = Comment.new
  end

  def index
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      @pictures = @user.pictures.joins(:genre).where(genres: {is_active: true})
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures
    else
      @pictures = Picture.joins(:genre).where(genres: {is_active: true})
    end
  end

  def bookmarks
    @bookmarks = current_user.bookmarks
  end

  def comics
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      @pictures = @user.pictures.where(status: "マンガ").joins(:genre).where(genres: {is_active: true})
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures.where(status: "マンガ")
    else
      @pictures = Picture.where(status: "マンガ").joins(:genre).where(genres: {is_active: true})
    end
  end

  def illustrations
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      @pictures = @user.pictures.where(status: "イラスト").joins(:genre).where(genres: {is_active: true})
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures.where(status: "イラスト")
    else
      @pictures = Picture.where(status: "イラスト").joins(:genre).where(genres: {is_active: true})
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to user_path(current_user)
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :introduction, :genre_id, :status, picture_images_images: [])
  end

  def picture_operation_user
    if current_user.status == "無料会員"
      redirect_to user_path(current_user)
    end
  end
end
