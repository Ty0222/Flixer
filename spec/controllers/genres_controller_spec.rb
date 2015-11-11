describe GenresController do
	
	context	"when not logged in as admin" do

		before do
			@genre = Genre.create!(name: "Genre 1")
			@user = User.create!(user_attributes(admin: false))
			session[:user_id] = @user.username
		end
		
		it "cannot access new action" do
			get :new

			expect(response).to redirect_to(root_url)
		end

		it "cannot access create action" do
			post :create

			expect(response).to redirect_to(root_url)
		end

		it "cannot access edit action" do
			get :edit, id: @genre

			expect(response).to redirect_to(root_url)
		end

		it "cannot access update action" do
			patch :update, id: @genre

			expect(response).to redirect_to(root_url)
		end

		it "cannot access destroy action" do
			delete :destroy, id: @genre

			expect(response).to redirect_to(root_url)
		end
	
	end

end
