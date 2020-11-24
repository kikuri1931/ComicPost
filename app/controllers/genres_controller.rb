class GenresController < ApplicationController
	before_action :authenticate_user!
	before_action :admin_user
  	def index
	  @genres = Genre.all.page(params[:page]).per(10)
	  @genre = Genre.new
	end

	def create
	  @genre = Genre.new(genre_params)
	  if @genre.save
	  	redirect_to genres_path, alert: "ジャンル追加が無事成功しました。"
	  else
	  	@genres = Genre.all.page(params[:page]).per(10)
	  	render :index
	  end
	end

	def edit
		@genre = Genre.find(params[:id])
	end

	def update
	  @genre = Genre.find(params[:id])
	  if @genre.update(genre_params)
	  	redirect_to genres_path, alert: "ジャンル変更が無事成功しました。"
	  else
	  	render :edit
	  end
	end

	private
	def genre_params
		params.require(:genre).permit(:genre, :is_active)
	end

	def admin_user
    unless current_user.status == "講師"
      redirect_to user_path(current_user)
    end
  end
end
