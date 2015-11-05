describe FavoritesController do
	
	before { @movie = Movie.create!(movie_attributes) }

	context "when not logged in" do

		before { session[:user_id] = nil }
		
		it "cannot access create action" do
			post :create, movie_id: @movie.id

			expect(response).to redirect_to(login_path)
		end

		it "cannot access destroy action" do
			delete :destroy, id: 1, movie_id: @movie.id

			expect(response).to redirect_to(login_path)
		end
	end
end