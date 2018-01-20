class MovieFiltersController < ApplicationController
  skip_before_action :require_login

  def index_by_genre
    filtered_movies = Movie.now_playing_by_genre(with_genres: params[:genre_ids], page: params[:page], hit_status: params[:hit_status])
    filtered_movies_metadata = Movie.filtered_movie_list_metadata(with_genres: params[:genre_ids], page: params[:page], hit_status: params[:hit_status])
    
    @movies = MovieDecorator.decorate(filtered_movies)
    @movies_metadata = MovieMetadataByGenreDecorator.decorate(filtered_movies_metadata, genre_ids: params[:genre_ids])
  end

end