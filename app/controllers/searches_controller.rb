class SearchesController < ApplicationController
	before_action :authenticate_user!
	
	def search
		@range = params[:range]
		word = params[:word]

		if @range == "1"
			@users = User.search_user(word).page(params[:page]).per(10)
		elsif @range == "2"
			@pictures = Picture.search_picture("マンガ", word).page(params[:page]).per(30)
		elsif @range == "3"
			@pictures = Picture.search_picture("イラスト", word).page(params[:page]).per(30)
		else
			genres = Genre.search_genre(word)
			@genre_pictures = Picture.where(genre_id: genres).page(params[:page]).per(30)
		end
	end
end
