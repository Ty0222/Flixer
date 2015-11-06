class GenresController < ApplicationController
	before_action :require_login, except: [:index]
	before_action :require_admin_user, except: [:index]
	before_action :set_genre, only: [:edit, :update, :destroy]
	
	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			redirect_to root_url, notice: "New genre added!"
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @genre.update(genre_params)
			redirect_to root_url, notice: "Genre successfully updated!"
		else
			render :edit
		end
	end

	def index
		@genres = Genre.all
	end

	def destroy
		@genre.destroy
		redirect_to genres_url, notice: "Genre successfully deleted!"
	end

	private

	def genre_params
		params.require(:genre).permit(:name)
	end

	def set_genre
		@genre = Genre.find(params[:id])
	end

end
