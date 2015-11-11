describe MoviesController do

	before { @movie = Movie.create(movie_attributes) }
	
	context "when not an admin user" do

		before do
			@user = User.create(user_attributes(admin: false))
			session[:user_id] = @user.username
		end
		
		it "cannot access new action" do
			get :new

			expect(response).to redirect_to(root_url)
		end

		it "cannot access create action" do
			post :create, id: @user

			expect(response).to redirect_to(root_url)
		end

		it "cannot access edit action" do
			get :edit, id: @user

			expect(response).to redirect_to(root_url)
		end

		it "cannot access update action" do
			patch :update, id: @user

			expect(response).to redirect_to(root_url)
		end

		it "cannot access destroy action" do
			delete :destroy, id: @user

			expect(response).to redirect_to(root_url)
		end

	end

end