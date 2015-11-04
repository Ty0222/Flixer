describe "Deleting A Movie" do

	context "when admin user" do
	
		before { @user = User.create(user_attributes) }
		
		it "removes a movie with message of success and redirects to home page" do
			movie = Movie.create(movie_attributes)

			login(@user)
			visit movie_url(movie)
			click_link "Delete"

			expect(current_path).to eq(movies_path)
			expect(page).to_not have_content(movie.title)
			expect(page).to have_content("Movie successfully deleted!")
		end
	end
end