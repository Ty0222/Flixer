Rails.application.routes.draw do
  
  resources :genres, except: :show
	get "/signup" => "users#new"
	get "/login" => "sessions#new"
	resources :users
  resource :session
  root "movies#index"
  get "/genres/:id" => "movies#index_all_from_genre", as: :genre_movies
  get "movies/filter/:scope" => "movies#index", as: :filtered_movies
  resources :movies do
  	resources :reviews
  	resources :favorites
  end
end
