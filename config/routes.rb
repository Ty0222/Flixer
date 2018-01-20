Rails.application.routes.draw do
  root "movies#index"
    
	get "/signup" => "users#new"
	get "/login" => "sessions#new"
  resource :session

	resources :users

  resources :genres, only: :index

  get "/movies/catalog/page/:page" => "movies#index", as: :movies, defaults: { page: "1" }
  get "/movies/catalog/filters/genres/:genre_ids/page/:page" => "movie_filters#index_by_genre",
   as: :filtered_movies_by_genre, defaults: { page: "1" }
  resources :movies

end
