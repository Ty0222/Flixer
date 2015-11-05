class MoviesController < ApplicationController
	skip_before_action :require_login, only: [:show, :index]
	before_action :set_movie, except: [:index, :new, :create]
	before_action :require_admin_user, except: [:index, :show]

	def index
		@movies = Movie.released_movies
	end

	def show
		@fans = @movie.fans
		if current_user
			@current_favorite = current_user.favorites.find_by(movie_id: @movie.id)
		end
	end

	def edit
	end

	def update
		if @movie.update(movie_params)
			redirect_to @movie, notice: "Movie successfully updated!"
		else
			render :edit
		end
	end

	def new
		@movie = Movie.new
	end

	def create
		@movie = Movie.new(movie_params)
		if @movie.save
			redirect_to @movie, notice: "Movie successfully created!"
		else
			render :new
		end
	end

	def destroy
		@movie.destroy
		redirect_to movies_url, notice: "Movie successfully deleted!"
	end

	private

	def movie_params
		params.require(:movie).
			permit(:title, :rating, :total_gross,
			:description, :released_on, :cast,
			:director, :duration, :image)		
	end

	def set_movie
		@movie = Movie.find(params[:id])		
	end
end