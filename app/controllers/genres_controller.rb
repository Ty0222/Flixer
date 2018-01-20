class GenresController < ApplicationController
	before_action :require_login, except: [:index]
	before_action :require_admin_user, except: [:index]
	before_action :set_genre, only: [:edit, :update, :destroy]

	def index
		@genres = Genre.all
	end

end
