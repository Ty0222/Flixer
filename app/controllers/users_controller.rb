class UsersController < ApplicationController
	skip_before_action :require_login, only: [:new, :create]
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :require_current_user, only: [:edit, :update, :destroy] 

	def index
		@users = User.non_admins
	end

	def show
		@reviews = @user.reviews
		@favorite_movies = @user.favorite_movies
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.username
			redirect_to user_path(@user.username), notice: "Thanks for signing up!"
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user.username), notice: "Account successfully updated!"
		else
			render :edit
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		redirect_to root_url, notice: "Account successfully deleted!"
	end

private

	def user_params
		params.require(:user).
			permit(:name, :username, :email, :password, :password_confirmation)
	end

	def set_user
		@user = User.find_by(username: params[:id]) || @user = User.find(params[:id])
	end

	def require_current_user
		unless current_user?(@user)
			redirect_to users_url, alert: "You do not have permission to do that!"
		end
	end
end