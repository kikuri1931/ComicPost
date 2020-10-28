class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :picture_add_user, only: [:new,:create]
  before_action :picture_destroy_user, only: [:destroy]
  before_action :picture_edit_user, only: [:edit, :update]

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
    if @picture.user.is_deleted && ['有料会員', '無料会員'].include?(current_user.status)
      redirect_to user_path(current_user)
    end
    if !@picture.genre.is_active && ['有料会員', '無料会員'].include?(current_user.status)
      redirect_to user_path(current_user)
    end
    @picture_destroy_user = @picture.user == current_user ||
                            current_user.status == "講師"
    @pictures = @picture.user.pictures.limit(3)
    @picture_images = @picture.picture_images
    @comment = Comment.new
  end

  def index
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user.is_deleted && ['有料会員', '無料会員'].include?(current_user.status)
        redirect_to user_path(current_user)
      end
      @pictures = @user.pictures.genre_active.page(params[:page]).per(30)
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures.user_active.page(params[:page]).per(18)
    else
      @pictures = Picture.genre_user_active.page(params[:page]).per(12)
    end
  end

  def bookmarks
    @bookmarks = current_user.bookmarks.joins(:user).where(users: {is_deleted: false})
  end

  def comics
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user.is_deleted && ['有料会員', '無料会員'].include?(current_user.status)
        redirect_to user_path(current_user)
      end
      @pictures = @user.pictures.picture_genre_active("マンガ").page(params[:page]).per(30)
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures.picture_user_active("マンガ").page(params[:page]).per(18)
    else
      @pictures = Picture.picture_user_genre_active("マンガ").page(params[:page]).per(12)
    end
  end

  def illustrations
    @genres = Genre.where(is_active: true)
    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user.is_deleted && ['有料会員', '無料会員'].include?(current_user.status)
        redirect_to user_path(current_user)
      end
      @pictures = @user.pictures.picture_genre_active("イラスト").page(params[:page]).per(30)
    elsif params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @pictures = @genre.pictures.picture_user_active("イラスト").page(params[:page]).per(18)
    else
      @pictures = Picture.picture_user_genre_active("イラスト").page(params[:page]).per(12)
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to picture_path(@picture)
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to user_path(current_user), alert: "削除が無事に完了しました。"
  end

  private
  def picture_params
    params.require(:picture)
          .permit(:title, :introduction, :genre_id, :status, picture_images_images: [])
  end

  def picture_add_user
    if current_user.status == "無料会員"
      redirect_to user_path(current_user)
    end
  end

  def picture_destroy_user
    @picture = Picture.find(params[:id])
    unless @picture.user == current_user || current_user.status == "講師"
      redirect_to user_path(current_user)
    end
  end

  def picture_edit_user
    @picture = Picture.find(params[:id])
    unless @picture.user == current_user
      redirect_to user_path(current_user)
    end
  end

  def check_registration(user, login_user)
    user.is_deleted && login_user.status == "講師"
  end
end
