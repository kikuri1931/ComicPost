class PicturesController < ApplicationController
  def new
  	@picture = Picture.new 
  	@picture.picture_images.build
  end

  def create
  	@picture = Picture.new (picture_params)
  	@picture.user_id = current_user.id
	  @picture.save
    redirect_to picture_path(@picture)
  end

  def show
  	@picture = Picture.find(params[:id])
    @pictures = @picture.user.pictures.limit(3)
    @picture_images = @picture.picture_images
  end

  def edit
  end

  private

  def picture_params
    params.require(:picture).permit(:title, :introduction, :genre_id, :status, picture_images_attributes:[:id, :image])
  end
end
