class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @picture = Picture.find(params[:picture_id])
    favorite = current_user.favorites.new(picture_id: @picture.id)
    favorite.save
  end

  def destroy
    @picture = Picture.find(params[:picture_id])
    favorite = current_user.favorites.find_by(picture_id: @picture.id)
    if current_user.favorites.find_by(picture_id: @picture.id) 
      favorite.destroy
   end
  end
end
