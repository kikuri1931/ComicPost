class SearchesController < ApplicationController
	before_action :authenticate_user!
	def search
		@range = params[:range]
		word = params[:word]

		if @range == '1'
			@users = User.search_user(word).page(params[:page]).per(10)
		elsif @range == '2'
			@pictures = Picture.where(status: "マンガ").where("title LIKE?","%#{word}%").page(params[:page]).per(20)
		elsif @range == '3'
			@pictures = Picture.where(status: "イラスト").where("title LIKE?","%#{word}%").page(params[:page]).per(20)
		else
			@genres = Genre.where("genre LIKE?","%#{word}%")
		end
	end
end
