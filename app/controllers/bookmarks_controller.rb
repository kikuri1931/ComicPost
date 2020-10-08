class BookmarksController < ApplicationController
	def create
	    picture = Picture.find(params[:picture_id])
	    bookmark = current_user.bookmarks.new(picture_id: picture.id)
	    bookmark.save
	    redirect_back(fallback_location: picture_path(picture))
	end

	def destroy
	   picture = Picture.find(params[:picture_id])
	   bookmark = current_user.bookmarks.find_by(picture_id: picture.id)
	   if current_user.bookmarks.find_by(picture_id: picture.id) != nil
		  bookmark.destroy
		end
		redirect_back(fallback_location: picture_path(picture))
	end
end
