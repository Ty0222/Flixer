Rails.application.routes.draw do
  
  resources :genres, except: :show
  get "/genres/:id" => "movies#index_all_from_genre", as: :genre_movies
	get "/signup" => "users#new"
	get "/login" => "sessions#new"
	resources :users
  resource :session
  root "movies#index"	  
  resources :movies do
  	resources :reviews
  	resources :favorites
  end
end
