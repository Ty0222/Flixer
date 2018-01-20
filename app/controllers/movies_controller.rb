class MoviesController < ApplicationController
	skip_before_action :require_login, only: [:show, :index, :index_all_from_genre]
	before_action :require_admin_user, except: [:index_all_from_genre, :index, :show]
	
	def index
		movies = Movie.now_playing(page: params[:page], hit_status: params[:hit_status])
		movies_metadata = Movie.movie_list_metadata(page: params[:page], hit_status: params[:hit_status])

		@movies = MovieDecorator.decorate(movies)
		@movies_metadata = MovieMetadataDecorator.decorate(movies_metadata)
	end

	def show
		get_movie
	end

	private

	def get_movie
		@movie = MovieDecorator.decorate(Movie.get_movie(id: params[:id]))
	end
	
end