class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def create
    @picture = Picture.find(params[:picture_id])
    bookmark = current_user.bookmarks.new(picture_id: @picture.id)
    bookmark.save
  end

  def destroy
    @picture = Picture.find(params[:picture_id])
    bookmark = current_user.bookmarks.find_by(picture_id: @picture.id)
    if current_user.bookmarks.find_by(picture_id: @picture.id) != nil
      bookmark.destroy
   end
  end
end
