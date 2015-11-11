class MoviesController < ApplicationController
	skip_before_action :require_login, only: [:show, :index, :index_all_from_genre]
	before_action :require_admin_user, except: [:index_all_from_genre, :index, :show]
	before_action :set_movie, except: [:index, :index_all_from_genre, :new, :create]
	

	def index
		@movies = Movie.send(movies_scope)
	end

	def index_all_from_genre
		@genre = Genre.find(params[:id])
		@movies = Movie.all_from_genre(@genre)
	end

	def show
		@fans = @movie.fans
		@genres = @movie.genres
		if current_user
			@current_favorite = current_user.favorites.find_by(movie_slug: @movie)
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
			:director, :duration, :image, genre_ids: [])		
	end

	def set_movie
		@movie = Movie.find(params[:id])		
	end

	def movies_scope
		if params[:scope].in? %w(upcoming recent flops hits)
			params[:scope]
		else
			:released_movies
		end
	end
end