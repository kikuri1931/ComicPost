class SearchesController < ApplicationController
	before_action :authenticate_user!
	def search
		@range = params[:range]
		word = params[:word]

		if @range == '1'
			@users = User.search_user(word)
		elsif @range == '2'
			@pictures = Picture.where(status: "マンガ").where("title LIKE?","%#{word}%")
		elsif @range == '3'
			@pictures = Picture.where(status: "イラスト").where("title LIKE?","%#{word}%")
		else
			@genres = Genre.where("genre LIKE?","%#{word}%")
		end
	end
end
