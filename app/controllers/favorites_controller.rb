class FavoritesController < ApplicationController
	before_action :require_login
	before_action :set_movie

	def create
		@movie.fans << current_user
		redirect_to @movie
	end

	def destroy
		favorite = current_user.favorites.find_by(movie_slug: @movie)
		favorite.destroy
		redirect_to @movie
	end

private

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end
end
