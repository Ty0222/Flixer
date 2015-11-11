describe UsersController do
	
	before { @user = User.create(user_attributes) }

	context "when not signed in" do
		
		before { session[:user_id] = nil }

		it "cannot access index" do
			get :index

			expect(response).to redirect_to(login_url)
		end
		
		it "cannot access show" do
			get :show, id: @user

			expect(response).to redirect_to(login_url)
		end
		
		it "cannot access edit" do
			get :edit, id: @user

			expect(response).to redirect_to(login_url)
		end
		
		it "cannot access update" do
			patch :update, id: @user

			expect(response).to redirect_to(login_url)
		end
		
		it "cannot access destroy" do
			delete :destroy, id: @user

			expect(response).to redirect_to(login_url)
		end
	
	end

	context "when signed in as the wrong user" do
			
		before do
		 @wrong_user = User.create(user_attributes(email: "wrong@example.com", username: "WR0222"))
			session[:user_id] = @wrong_user.username
		end

		it "cannot edit another user" do
			get :edit, id: @user

			expect(response).to redirect_to(users_url)
		end
	
		it "cannot update another user" do
			patch :update, id: @user 

			expect(response).to redirect_to(users_url)
		end
	
		it "cannot destroy another user" do
			delete :destroy, id: @user

			expect(response).to redirect_to(users_url)
		end

	end

end